`timescale 1 ns / 1 ns

/*
 * This FSM determines control signals to inFIFOs to determine
 * how to route incoming data from DRAM.
 */
module encoder_dram_rrsp_fsm #(
  parameter IMG_RBURST_LEN = 128,
  parameter NUM_RREQS_PER_CIMG = 7200,
  parameter NUM_CIMG_RREQS_PER_MSG_RREQ = 512
) (
  input wire axi_clk,
  input wire axi_resetn,
  input wire begin_encoding,
  input wire incoming_data_valid, 

  output wire msg_infifo_wr_en,
  output wire cimg_infifo_wr_en,
  output reg finished_receiving_frame
);

// DRAM read resp states
enum {
  RRSP_IDLE, WAIT_FIRST_MSG, WAIT_MSG, WAIT_CIMG
} rrsp_state;
reg [$clog2(IMG_RBURST_LEN+1)-1:0] curr_rburst_cnt;
reg [$clog2(NUM_RREQS_PER_CIMG+1)-1:0] num_cimg_rrsps;
reg [$clog2(NUM_CIMG_RREQS_PER_MSG_RREQ+1)-1:0] num_consecutive_cimg_rrsp;
reg next_data_is_msg;

// Outstanding encoding request declarations
// Assume less than 16 outstanding requests at any given time.
reg [3:0] outstanding_encoding_requests_receipts;
reg handled_a_begin_encoding_receipt;

/* Outstanding encode request FSM - on the receive side. */
always_ff @ (posedge axi_clk) begin
  if (!axi_resetn) begin
    outstanding_encoding_requests_receipts <= 0;
  end else begin
    if (begin_encoding) begin
      outstanding_encoding_requests_receipts <= outstanding_encoding_requests_receipts + 1'b1;
    end else if (handled_a_begin_encoding_receipt) begin
      outstanding_encoding_requests_receipts <= outstanding_encoding_requests_receipts - 1'b1;
    end else begin
      outstanding_encoding_requests_receipts <= outstanding_encoding_requests_receipts;
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
    next_data_is_msg <= 1'b1;
    num_cimg_rrsps <= 1;
    num_consecutive_cimg_rrsp <= 1;
    handled_a_begin_encoding_receipt <= 1'b0;
    finished_receiving_frame <= 1'b0;
  end else begin
    // Defaults
    rrsp_state <= rrsp_state;
    next_data_is_msg <= next_data_is_msg;
    curr_rburst_cnt <= curr_rburst_cnt;
    num_cimg_rrsps <= num_cimg_rrsps;
    num_consecutive_cimg_rrsp <= num_consecutive_cimg_rrsp;
    handled_a_begin_encoding_receipt <= 1'b0;
    finished_receiving_frame <= finished_receiving_frame;

    case (rrsp_state)
      RRSP_IDLE: begin
        // Start requesting if outstanding encoding requests exist.
        // We first read msg data.
        if (outstanding_encoding_requests_receipts != 0) begin
          handled_a_begin_encoding_receipt <= 1'b1;
          rrsp_state <= WAIT_FIRST_MSG;
          next_data_is_msg <= 1'b1;
        end
      end

      WAIT_FIRST_MSG: begin
        if (incoming_data_valid) begin
          if (curr_rburst_cnt >= IMG_RBURST_LEN) begin
            // Received last word of msg burst, receive cover img burst
            rrsp_state <= WAIT_MSG;
            curr_rburst_cnt <= 1;
          end else begin
            // Wait for end of this burst
            curr_rburst_cnt <= curr_rburst_cnt + 1'b1;
          end
        end
      end

      WAIT_MSG: begin
        if (incoming_data_valid) begin
          if (curr_rburst_cnt >= IMG_RBURST_LEN) begin
            // Received last word of msg burst, receive cover img burst
            rrsp_state <= WAIT_CIMG;
            curr_rburst_cnt <= 1;
            next_data_is_msg <= 1'b0;
          end else begin
            // Wait for end of this burst
            curr_rburst_cnt <= curr_rburst_cnt + 1'b1;
          end
        end
      end

      WAIT_CIMG: begin
        if (incoming_data_valid) begin
          finished_receiving_frame <=1'b0;
          if (curr_rburst_cnt >= IMG_RBURST_LEN) begin
            curr_rburst_cnt <= 1;
            num_cimg_rrsps <= num_cimg_rrsps + 1'b1;

            // Received last word of burst, decide what to do next
            if (num_cimg_rrsps >= NUM_RREQS_PER_CIMG) begin
              // If we received the entire cover image, then we're done.
              num_cimg_rrsps <= 1;
              num_consecutive_cimg_rrsp <= 1;
              rrsp_state <= RRSP_IDLE;
              finished_receiving_frame <= 1'b1;
            end else if (num_consecutive_cimg_rrsp >= NUM_CIMG_RREQS_PER_MSG_RREQ) begin
              // If we consumed all the msg bits, we will be receiving more of the message.
              num_consecutive_cimg_rrsp <= 1;
              next_data_is_msg <= 1'b1;
              rrsp_state <= WAIT_MSG;
            end else begin
              // Otherwise we will be getting more cover image data
              num_consecutive_cimg_rrsp <= num_consecutive_cimg_rrsp + 1'b1;
              rrsp_state <= WAIT_CIMG;
            end

          end else begin
            // Wait for end of this burst
            curr_rburst_cnt <= curr_rburst_cnt + 1'b1;
          end
        end
      end
    endcase
  end
end


// inFIFO enable logic
assign msg_infifo_wr_en = incoming_data_valid && next_data_is_msg;
assign cimg_infifo_wr_en = incoming_data_valid && !next_data_is_msg;

endmodule: encoder_dram_rrsp_fsm