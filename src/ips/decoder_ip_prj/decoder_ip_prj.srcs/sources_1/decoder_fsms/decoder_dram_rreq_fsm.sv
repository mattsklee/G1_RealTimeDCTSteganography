`timescale 1 ns / 1 ns

/*
 * This FSM determines read control signals to DRAM through the
 * full AXI master.
 */
module decoder_dram_rreq_fsm #(
  parameter ADDR_WIDTH = 32,
  parameter DATA_WIDTH = 32,
  parameter IMG_RBURST_LEN = 128,
  parameter NUM_RREQS_PER_SIMG = 7200
) (
  input wire axi_clk,
  input wire axi_resetn,
  input wire [ADDR_WIDTH-1:0] msg_baddr,
  input wire [ADDR_WIDTH-1:0] simg_baddr,
  input wire begin_decoding,
  input wire axi_m_can_accept_rreq,
  input wire simg_infifo_has_space,

  output reg [ADDR_WIDTH-1:0] dram_raddr,
  output reg dram_rreq
);

localparam BYTES_READ_PER_BURST = IMG_RBURST_LEN*DATA_WIDTH/8;

// DRAM read req states
enum {
  RREQ_IDLE, GET_SIMG, RREQ_DECIDE_NEXT
} rreq_state;

reg [ADDR_WIDTH-1:0] msg_addr;
reg [ADDR_WIDTH-1:0] simg_addr;
reg [$clog2(NUM_RREQS_PER_SIMG+1)-1:0] num_simg_rreqs;

// Outstanding decoding request declarations
// Assume less than 8 outstanding requests at any given time.
reg [2:0] outstanding_decoding_requests;
reg handled_a_begin_decoding;

/* Outstanding decode request FSM */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    outstanding_decoding_requests <= 0;
  end else begin
    if (begin_decoding) begin
      outstanding_decoding_requests <= outstanding_decoding_requests + 1'b1;
    end else if (handled_a_begin_decoding) begin
      outstanding_decoding_requests <= outstanding_decoding_requests - 1'b1;
    end else begin
      outstanding_decoding_requests <= outstanding_decoding_requests;
    end
  end
end


/* DRAM read request FSM */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    rreq_state <= RREQ_IDLE;
    msg_addr <= msg_baddr;
    simg_addr <= simg_baddr;
    dram_raddr <= simg_baddr;
    dram_rreq <= 1'b0;
    num_simg_rreqs <= 1;
    handled_a_begin_decoding <= 1'b0;
  end else begin
    // By default, use stego image addresses.
    dram_raddr <= simg_addr;

    // Other defaults
    rreq_state <= rreq_state;
    msg_addr <= msg_addr;
    simg_addr <= simg_addr;
    dram_rreq <= 1'b0;
    num_simg_rreqs <= num_simg_rreqs;
    handled_a_begin_decoding <= 1'b0;


    case (rreq_state)
      RREQ_IDLE: begin
        msg_addr <= msg_baddr;  // Load base msg addr
        simg_addr <= simg_baddr; // Load base stego img

        // Start requesting if outstanding decoding requests exist
        if (outstanding_decoding_requests != 0) begin
          handled_a_begin_decoding <= 1'b1;
          rreq_state <= GET_SIMG;
        end
      end

      GET_SIMG: begin
        // If AXI master can accept read requests (i.e., no burst transaction occuring)
        // AND the in-data FIFO has room, start read burst. Otherwise, wait for it.
        if (axi_m_can_accept_rreq && simg_infifo_has_space) begin
          // Increment image offset by number of bytes read 
          simg_addr <= simg_addr + BYTES_READ_PER_BURST;
          rreq_state <= RREQ_DECIDE_NEXT;
          dram_rreq <= 1'b1;
        end
      end


      RREQ_DECIDE_NEXT: begin
        if (num_simg_rreqs >= NUM_RREQS_PER_SIMG) begin
          // If we requested the entire cover image, then we're done.
          num_simg_rreqs <= 1;
          rreq_state <= RREQ_IDLE;
        end else begin
          // Otherwise we must get more cover image data
          num_simg_rreqs <= num_simg_rreqs + 1'b1;
          rreq_state <= GET_SIMG;
        end
      end
    endcase
  end
end



endmodule: decoder_dram_rreq_fsm