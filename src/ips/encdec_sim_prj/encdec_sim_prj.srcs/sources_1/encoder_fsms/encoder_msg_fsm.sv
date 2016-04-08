`timescale 1 ns / 1 ns

/*
 * This FSM handles msg bits to be encoded into cover image.
 */
module encoder_msg_fsm #(
  parameter IMG_RBURST_LEN = 128,
  parameter NUM_RREQS_PER_CIMG = 7200,
  parameter NUM_CIMG_RREQS_PER_MSG_RREQ = 512
) (
  input wire encoder_clk,
  input wire encoder_reset,
  input wire [31:0] next_msg_word,
  input wire msg_infifo_empty,
  input wire cimg_infifo_empty,

  output reg get_next_msg_word,
  output reg [3:0] current_msg_nibble
);

// Msg handling states
enum {
  MSG_IDLE,
  GET_FIRST_MSG_WORD_D,
  GET_FIRST_MSG_WORD,
  UPDATE_MSG_BIT_NORMAL,
  UPDATE_MSG_BIT_GET_NEXT_WORD_D,
  UPDATE_MSG_BIT_GET_NEXT_WORD,
  HANDLE_WORD_SWITCH
} msg_state;


/*
  Control block for msg_in input to actual encoder.

  The steganographic encoder currently encodes 1 bit of the hidden message
  into every 8x8 block of pixels. As it accepts one byte of the 8x8 block
  per cycle, 1 bit of msg is encoded every 64 cycles.
*/
reg [4:0] next_msg_msb;
reg [6:0] msg_incr_cntr;
reg [31:0] current_msg_word;
reg [31:0] temp_msg_word;

always_ff @ (posedge encoder_clk) begin
  if (encoder_reset) begin
    current_msg_word <= 0;
    temp_msg_word <= 0;
    current_msg_nibble <= 0;
    next_msg_msb <= 3;
    get_next_msg_word <= 1'b0;
    msg_incr_cntr <= 7'd1;
  end else begin
    current_msg_nibble <= current_msg_nibble;
    current_msg_word <= current_msg_word;
    temp_msg_word <= temp_msg_word;
    next_msg_msb <= next_msg_msb;
    get_next_msg_word <= 1'b0;
    msg_state <= msg_state;
    msg_incr_cntr <= msg_incr_cntr;

    case (msg_state)
      MSG_IDLE: begin
        if (!msg_infifo_empty) begin
          get_next_msg_word <= 1'b1;
          msg_state <= GET_FIRST_MSG_WORD_D;
        end
      end

      GET_FIRST_MSG_WORD_D: begin
        // 1 extra cycle of read latency
        msg_state <= GET_FIRST_MSG_WORD;
      end

      GET_FIRST_MSG_WORD: begin
        current_msg_word <= next_msg_word;
        current_msg_nibble <= next_msg_word[3:0];
        next_msg_msb <= 7;
        msg_state <= UPDATE_MSG_BIT_NORMAL;
      end

      UPDATE_MSG_BIT_NORMAL: begin
        // Encoder runs 1 cycle each time cimg fifo is read from 
        if (!cimg_infifo_empty) begin
          msg_incr_cntr <= msg_incr_cntr + 1'b1;

          // Get new bit of msg every 64 cycles
          if (msg_incr_cntr[6] == 1) begin
            msg_incr_cntr <= 7'd1;
            current_msg_nibble <= current_msg_word[next_msg_msb -: 4];
            next_msg_msb <= next_msg_msb + 4;
          end
        end
        // If the current msg word is almost consumed, request next one.
        if (next_msg_msb == 3) begin
          get_next_msg_word <= 1'b1;
          msg_state <= UPDATE_MSG_BIT_GET_NEXT_WORD_D;
        end
      end

      UPDATE_MSG_BIT_GET_NEXT_WORD_D: begin
        // Encoder runs 1 cycle each time cimg fifo is read from 
        if (!cimg_infifo_empty) begin
          msg_incr_cntr <= msg_incr_cntr + 1'b1;
          // Counter is guaranteed to never be 64 already - switched to
          // this state when it reached 64 so it's 1 at this point.
        end
        msg_state <= UPDATE_MSG_BIT_GET_NEXT_WORD;
      end


      UPDATE_MSG_BIT_GET_NEXT_WORD: begin
        // Encoder runs 1 cycle each time cimg fifo is read from 
        if (!cimg_infifo_empty) begin
          msg_incr_cntr <= msg_incr_cntr + 1'b1;

          // Counter is guaranteed to never be 64 already - switched to
          // this state when it reached 64 so it's 2 at this point.
        end
        temp_msg_word <= next_msg_word;
        msg_state <= HANDLE_WORD_SWITCH;
      end

      HANDLE_WORD_SWITCH: begin
        // Stay in this state until we finish consuming the previous
        // msg word.
        if (!cimg_infifo_empty) begin
          msg_incr_cntr <= msg_incr_cntr + 1'b1;

          // Finished using bit 32 of prev word. Switch words
          if (msg_incr_cntr[6] == 1) begin
            msg_incr_cntr <= 7'd1;
            current_msg_nibble <= temp_msg_word[next_msg_msb -: 4];
            current_msg_word <= temp_msg_word;
            next_msg_msb <= next_msg_msb + 4;
            msg_state <= UPDATE_MSG_BIT_NORMAL;
          end
        end
      end
    endcase
  end
end

endmodule: encoder_msg_fsm