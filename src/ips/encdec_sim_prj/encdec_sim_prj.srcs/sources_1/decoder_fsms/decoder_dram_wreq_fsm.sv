`timescale 1 ns / 1 ns

/*
 * This FSM determines write control signals to DRAM through the
 * full AXI master.
 */
module decoder_dram_wreq_fsm #(
  parameter ADDR_WIDTH = 32,
  parameter DATA_WIDTH = 32,
  parameter MSG_WBURST_LEN = 128,
  parameter NUM_WREQS_PER_SIMG = 1792
) (
  input wire axi_clk,
  input wire axi_resetn,
  input wire [ADDR_WIDTH-1:0] msg_baddr,
  input wire begin_decoding,
  input wire axi_m_can_accept_wreq,
  input wire wnext,  // Move onto next data of burst
  input wire msg_outfifo_has_enough_data,

  output reg [ADDR_WIDTH-1:0] dram_waddr,
  output reg dram_wreq,
  output reg msg_outfifo_first_rd_en,
  output reg done_decoding
);

localparam BYTES_WRITTEN_PER_BURST = MSG_WBURST_LEN*DATA_WIDTH/8;

// Retain base address associated with each begin decoding
// to ensure we write to the correct address.
reg get_next_msg_baddr;
wire [31:0] next_msg_baddr;
scfifo_32in_32out_1kb msg_baddr_fifo (
  .rst           ( !axi_resetn         ), // ASYNCHRONOUS reset; use axi clk
  .clk           ( axi_clk             ),
  .din           ( msg_baddr           ),
  .wr_en         ( begin_decoding      ),
  .rd_en         ( get_next_msg_baddr  ),
  .dout          ( next_msg_baddr      ), // Fall-through - no read latency
  .full          (  ),  // Unused
  .empty         (  )
);

// DDR write req states
enum {
  WREQ_IDLE, GET_MSG_BADDR, START_WRITE_MSG, WRITE_MSG, WREQ_DECIDE_NEXT
} wreq_state;

reg [$clog2(MSG_WBURST_LEN+1)-1:0] curr_wburst_cnt;
reg [ADDR_WIDTH-1:0] msg_addr;
reg [$clog2(NUM_WREQS_PER_SIMG+1)-1:0] num_msg_wreqs;

/* DDR write request 'FSM' */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    wreq_state <= WREQ_IDLE;
    curr_wburst_cnt <= 1;
    dram_wreq <= 1'b0;
    msg_addr <= 0;
    dram_waddr <= 0;
    num_msg_wreqs <= 1;
    get_next_msg_baddr <= 1'b0;
    done_decoding <= 1'b0;
    msg_outfifo_first_rd_en <= 1'b0;
  end else begin
    // Defaults
    wreq_state <= wreq_state;
    dram_wreq <= 1'b0;
    num_msg_wreqs <= num_msg_wreqs;
    msg_addr <= msg_addr;
    dram_waddr <= msg_addr; // Always this address.
    get_next_msg_baddr <= 1'b0;
    done_decoding <= 1'b0;
    msg_outfifo_first_rd_en <= 1'b0;

    case (wreq_state)
      WREQ_IDLE: begin
        if (msg_outfifo_has_enough_data) begin
          get_next_msg_baddr <= 1'b1;
          wreq_state <= GET_MSG_BADDR;
        end
      end

      GET_MSG_BADDR: begin
        // Start of new frame - init to base address
        msg_addr <= next_msg_baddr;
        wreq_state <= START_WRITE_MSG;
      end

      START_WRITE_MSG: begin
        if (msg_outfifo_has_enough_data && axi_m_can_accept_wreq) begin
          curr_wburst_cnt <= 1;
          dram_wreq <= 1'b1;
          wreq_state <= WRITE_MSG;
          msg_outfifo_first_rd_en <= 1'b1;
        end
      end

      WRITE_MSG: begin
        if (wnext) begin
          if (curr_wburst_cnt >= MSG_WBURST_LEN-1) begin // WNEXT is asserted 1 time less than total # of transactions...
            wreq_state <= WREQ_DECIDE_NEXT;
          end else begin
            curr_wburst_cnt <= curr_wburst_cnt + 1'b1;
          end
        end
      end

      WREQ_DECIDE_NEXT: begin
        if (num_msg_wreqs >= NUM_WREQS_PER_SIMG) begin
          // Wrote entire frame. Wait in idle for next frame.
          // Indicate that a frame is finished decoding.
          num_msg_wreqs <= 1;
          done_decoding <= 1'b1;
          wreq_state <= WREQ_IDLE;
        end else begin
          // Wrote burst. Prepare for next burst
          msg_addr <= msg_addr + BYTES_WRITTEN_PER_BURST;
          num_msg_wreqs <= num_msg_wreqs + 1'b1;
          wreq_state <= START_WRITE_MSG;
        end
      end
    endcase
  end
end


endmodule: decoder_dram_wreq_fsm