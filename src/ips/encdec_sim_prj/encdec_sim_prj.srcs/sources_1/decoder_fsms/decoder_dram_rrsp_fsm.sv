`timescale 1 ns / 1 ns

/*
 * This FSM determines control signals to inFIFOs to determine
 * when we finished receiving a frame of image..
 */
module decoder_dram_rrsp_fsm #(
  parameter IMG_RBURST_LEN = 128,
  parameter NUM_RREQS_PER_SIMG = 7200
) (
  input wire axi_clk,
  input wire axi_resetn,
  input wire begin_decoding,
  input wire incoming_data_valid, 

  output reg finished_receiving_frame
);

// DRAM read resp states
enum {
  RRSP_IDLE, WAIT_SIMG, RRSP_DECIDE_NEXT
} rrsp_state;
reg [$clog2(IMG_RBURST_LEN+1)-1:0] curr_rburst_cnt;
reg [$clog2(NUM_RREQS_PER_SIMG+1)-1:0] num_simg_rrsps;


// Outstanding decoding request declarations
// Assume less than 16 outstanding requests at any given time.
reg [3:0] outstanding_decoding_requests_receipts;
reg handled_a_begin_decoding_receipt;

/* Outstanding encode request FSM - on the receive side. */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    outstanding_decoding_requests_receipts <= 0;
  end else begin
    if (begin_decoding) begin
      outstanding_decoding_requests_receipts <= outstanding_decoding_requests_receipts + 1'b1;
    end else if (handled_a_begin_decoding_receipt) begin
      outstanding_decoding_requests_receipts <= outstanding_decoding_requests_receipts - 1'b1;
    end else begin
      outstanding_decoding_requests_receipts <= outstanding_decoding_requests_receipts;
    end
  end
end


/* DRAM read response FSM */
// Note that >= checks are used instead of == to simplify checking; 
// the values are always reset on those conditions anyway.
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    rrsp_state <= RRSP_IDLE;
    curr_rburst_cnt <= 1;
    num_simg_rrsps <= 1;
    handled_a_begin_decoding_receipt <= 1'b0;
    finished_receiving_frame <= 1'b0;
  end else begin
    // Defaults
    rrsp_state <= rrsp_state;
    curr_rburst_cnt <= curr_rburst_cnt;
    num_simg_rrsps <= num_simg_rrsps;
    handled_a_begin_decoding_receipt <= 1'b0;
    finished_receiving_frame <= finished_receiving_frame;

    case (rrsp_state)
      RRSP_IDLE: begin
        // Start requesting if outstanding decoding requests exist.
        // We first read msg data.
        if (outstanding_decoding_requests_receipts != 0) begin
          handled_a_begin_decoding_receipt <= 1'b1;
          rrsp_state <= WAIT_SIMG;
          curr_rburst_cnt <= 1;
        end
      end

      WAIT_SIMG: begin
        if (incoming_data_valid) begin
          finished_receiving_frame <=1'b0;
          if (curr_rburst_cnt >= IMG_RBURST_LEN) begin
            // Received last word of burst, decide what to do next
            rrsp_state <= RRSP_DECIDE_NEXT;
            curr_rburst_cnt <= 1;
            num_simg_rrsps <= num_simg_rrsps + 1'b1;
          end else begin
            // Wait for end of this burst
            curr_rburst_cnt <= curr_rburst_cnt + 1'b1;
          end
        end
      end

      RRSP_DECIDE_NEXT: begin
        if (num_simg_rrsps >= NUM_RREQS_PER_SIMG) begin
          // If we received the entire cover image, then we're done.
          num_simg_rrsps <= 1;
          rrsp_state <= RRSP_IDLE;
          finished_receiving_frame <= 1'b1;
        end else begin
          // Otherwise we will be getting more cover image data
          rrsp_state <= WAIT_SIMG;
        end
      end
    endcase
  end
end


endmodule: decoder_dram_rrsp_fsm