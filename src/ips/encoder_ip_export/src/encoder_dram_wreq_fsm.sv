`timescale 1 ns / 1 ns

/*
 * This FSM determines write control signals to DRAM through the
 * full AXI master.
 */
module encoder_dram_wreq_fsm #(
  parameter ADDR_WIDTH = 32,
  parameter DATA_WIDTH = 32,
  parameter IMG_WBURST_LEN = 128,
  parameter NUM_WREQS_PER_SIMG = 7200
) (
  input wire axi_clk,
  input wire axi_resetn,
  input wire [ADDR_WIDTH-1:0] simg_baddr,
  input wire begin_encoding,
  input wire axi_m_can_accept_wreq,
  input wire wnext,  // Move onto next data of burst
  input wire simg_outfifo_has_enough_data,

  output reg [ADDR_WIDTH-1:0] dram_waddr,
  output reg dram_wreq,
  output reg simg_outfifo_first_rd_en,
  output reg done_encoding
);

localparam BYTES_WRITTEN_PER_BURST = IMG_WBURST_LEN*DATA_WIDTH/8;

// Retain base address associated with each begin encoding
// to ensure we write to the correct address.
reg get_next_simg_baddr;
wire [31:0] next_simg_baddr;
scfifo_32in_32out_1kb simg_baddr_fifo (
  .rst           ( !axi_resetn         ), // ASYNCHRONOUS reset; use axi clk
  .clk           ( axi_clk             ),
  .din           ( simg_baddr          ),
  .wr_en         ( begin_encoding      ),
  .rd_en         ( get_next_simg_baddr ),
  .dout          ( next_simg_baddr     ), // Fall-through - no read latency
  .full          (  ),  // Unused
  .empty         (  )
);

// DDR write req states
enum {
  WREQ_IDLE, GET_SIM_BADDR, START_WRITE_SIMG, WRITE_SIMG, WREQ_DECIDE_NEXT
} wreq_state;

reg [$clog2(IMG_WBURST_LEN+1)-1:0] curr_wburst_cnt;
reg [ADDR_WIDTH-1:0] simg_addr;
reg [$clog2(NUM_WREQS_PER_SIMG+1)-1:0] num_simg_wreqs;

/* DDR write request 'FSM' */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    wreq_state <= WREQ_IDLE;
    curr_wburst_cnt <= 1;
    dram_wreq <= 1'b0;
    simg_addr <= 0;
    dram_waddr <= 0;
    num_simg_wreqs <= 1;
    get_next_simg_baddr <= 1'b0;
    done_encoding <= 1'b0;
    simg_outfifo_first_rd_en <= 1'b0;
  end else begin
    // Defaults
    wreq_state <= wreq_state;
    dram_wreq <= 1'b0;
    num_simg_wreqs <= num_simg_wreqs;
    simg_addr <= simg_addr;
    dram_waddr <= simg_addr; // Always this address.
    get_next_simg_baddr <= 1'b0;
    done_encoding <= 1'b0;
    simg_outfifo_first_rd_en <= 1'b0;

    case (wreq_state)
      WREQ_IDLE: begin
        if (simg_outfifo_has_enough_data) begin
          get_next_simg_baddr <= 1'b1;
          wreq_state <= GET_SIM_BADDR;
        end
      end

      GET_SIM_BADDR: begin
        // Start of new frame - init to base address
        simg_addr <= next_simg_baddr;
        wreq_state <= START_WRITE_SIMG;
      end

      START_WRITE_SIMG: begin
        if (simg_outfifo_has_enough_data && axi_m_can_accept_wreq) begin
          curr_wburst_cnt <= 1;
          dram_wreq <= 1'b1;
          wreq_state <= WRITE_SIMG;
          simg_outfifo_first_rd_en <= 1'b1;
        end
      end

      WRITE_SIMG: begin
        if (wnext) begin
          if (curr_wburst_cnt >= IMG_WBURST_LEN-1) begin // WNEXT is asserted 1 time less than total # of transactions...
            wreq_state <= WREQ_DECIDE_NEXT;
          end else begin
            curr_wburst_cnt <= curr_wburst_cnt + 1'b1;
          end
        end
      end

      WREQ_DECIDE_NEXT: begin
        if (num_simg_wreqs >= NUM_WREQS_PER_SIMG) begin
          // Wrote entire frame. Wait in idle for next frame.
          // Indicate that a frame is finished encoding.
          num_simg_wreqs <= 1;
          done_encoding <= 1'b1;
          wreq_state <= WREQ_IDLE;
        end else begin
          // Wrote burst. Prepare for next burst
          simg_addr <= simg_addr + BYTES_WRITTEN_PER_BURST;
          num_simg_wreqs <= num_simg_wreqs + 1'b1;
          wreq_state <= START_WRITE_SIMG;
        end
      end
    endcase
  end
end


endmodule: encoder_dram_wreq_fsm