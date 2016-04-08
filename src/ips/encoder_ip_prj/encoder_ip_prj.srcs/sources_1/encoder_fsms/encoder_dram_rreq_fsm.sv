`timescale 1 ns / 1 ns

/*
 * This FSM determines read control signals to DRAM through the
 * full AXI master.
 */
module encoder_dram_rreq_fsm #(
  parameter ADDR_WIDTH = 32,
  parameter DATA_WIDTH = 32,
  parameter IMG_RBURST_LEN = 128,
  parameter NUM_RREQS_PER_CIMG = 7200,
  parameter NUM_CIMG_RREQS_PER_MSG_RREQ = 512
) (
  input wire axi_clk,
  input wire axi_resetn,
  input wire [ADDR_WIDTH-1:0] msg_baddr,
  input wire [ADDR_WIDTH-1:0] cimg_baddr,
  input wire begin_encoding,
  input wire axi_m_can_accept_rreq,
  input wire msg_infifo_has_space,
  input wire cimg_infifo_has_space,

  output reg [ADDR_WIDTH-1:0] dram_raddr,
  output reg dram_rreq
);

localparam BYTES_READ_PER_BURST = IMG_RBURST_LEN*DATA_WIDTH/8;

// DRAM read req states
enum {
  RREQ_IDLE, GET_FIRST_MSG, GET_MSG, GET_CIMG, RREQ_DECIDE_NEXT
} rreq_state;

reg [ADDR_WIDTH-1:0] msg_addr;
reg [ADDR_WIDTH-1:0] cimg_addr;
reg [$clog2(NUM_RREQS_PER_CIMG+1)-1:0] num_cimg_rreqs;
reg [$clog2(NUM_CIMG_RREQS_PER_MSG_RREQ+1)-1:0] num_consecutive_cimg_rreq;

// Outstanding encoding request declarations
// Assume less than 8 outstanding requests at any given time.
reg [2:0] outstanding_encoding_requests;
reg handled_a_begin_encoding;

/* Outstanding encode request FSM */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    outstanding_encoding_requests <= 0;
  end else begin
    if (begin_encoding) begin
      outstanding_encoding_requests <= outstanding_encoding_requests + 1'b1;
    end else if (handled_a_begin_encoding) begin
      outstanding_encoding_requests <= outstanding_encoding_requests - 1'b1;
    end else begin
      outstanding_encoding_requests <= outstanding_encoding_requests;
    end
  end
end


/* DRAM read request FSM */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    rreq_state <= RREQ_IDLE;
    msg_addr <= msg_baddr;
    cimg_addr <= cimg_baddr;
    dram_raddr <= cimg_baddr;
    dram_rreq <= 1'b0;
    num_cimg_rreqs <= 1;
    num_consecutive_cimg_rreq <= 1;
    handled_a_begin_encoding <= 1'b0;
  end else begin
    // By default, use cover image addresses.
    dram_raddr <= cimg_addr;

    // Other defaults
    rreq_state <= rreq_state;
    msg_addr <= msg_addr;
    cimg_addr <= cimg_addr;
    dram_rreq <= 1'b0;
    num_cimg_rreqs <= num_cimg_rreqs;
    num_consecutive_cimg_rreq <= num_consecutive_cimg_rreq;
    handled_a_begin_encoding <= 1'b0;


    case (rreq_state)
      RREQ_IDLE: begin
        msg_addr <= msg_baddr;  // Load base msg addr
        cimg_addr <= cimg_baddr; // Load base cover img

        // Start requesting if outstanding encoding requests exist
        if (outstanding_encoding_requests != 0) begin
          handled_a_begin_encoding <= 1'b1;
          rreq_state <= GET_FIRST_MSG;
        end
      end

      // Get one burst of message early to ensure msg fifo is never empty
      GET_FIRST_MSG: begin
        // Select ARADDR to be message address.
        dram_raddr <= msg_addr;

        // If AXI master can accept read requests (i.e., no burst transaction occuring)
        // AND the in-data FIFO for msg has room, start read burst. Otherwise, wait for it.
        if (axi_m_can_accept_rreq && msg_infifo_has_space) begin
          // Increment msg offset by number of bytes read
          msg_addr <= msg_addr + BYTES_READ_PER_BURST;
          rreq_state <= GET_MSG;
          dram_rreq <= 1'b1;
        end
      end

      GET_MSG: begin
        // Select ARADDR to be message address.
        dram_raddr <= msg_addr;

        // If AXI master can accept read requests (i.e., no burst transaction occuring)
        // AND the in-data FIFO for msg has room, start read burst. Otherwise, wait for it.
        if (axi_m_can_accept_rreq && msg_infifo_has_space) begin
          // Increment msg offset by number of bytes read
          msg_addr <= msg_addr + BYTES_READ_PER_BURST;
          rreq_state <= GET_CIMG;
          dram_rreq <= 1'b1;
        end
      end

      GET_CIMG: begin
        // If AXI master can accept read requests (i.e., no burst transaction occuring)
        // AND the in-data FIFO has room, start read burst. Otherwise, wait for it.
        if (axi_m_can_accept_rreq && cimg_infifo_has_space) begin
          // Increment image offset by number of bytes read 
          cimg_addr <= cimg_addr + BYTES_READ_PER_BURST;
          rreq_state <= RREQ_DECIDE_NEXT;
          dram_rreq <= 1'b1;
        end
      end


      RREQ_DECIDE_NEXT: begin
        if (num_cimg_rreqs >= NUM_RREQS_PER_CIMG) begin
          // If we requested the entire cover image, then we're done.
          num_cimg_rreqs <= 1;
          num_consecutive_cimg_rreq <= 1;
          rreq_state <= RREQ_IDLE;
        end else begin
          num_cimg_rreqs <= num_cimg_rreqs + 1'b1;
          if (num_consecutive_cimg_rreq >= NUM_CIMG_RREQS_PER_MSG_RREQ) begin
            // If we consumed all the msg bits, request more of the message.
            num_consecutive_cimg_rreq <= 1;
            rreq_state <= GET_MSG;
          end else begin
            // Otherwise we must get more cover image data
            num_consecutive_cimg_rreq <= num_consecutive_cimg_rreq + 1'b1;
            rreq_state <= GET_CIMG;
          end
        end
      end
    endcase
  end
end



endmodule: encoder_dram_rreq_fsm