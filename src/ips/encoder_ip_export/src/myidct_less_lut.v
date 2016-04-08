`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2016 05:07:30 PM
// Design Name: 
// Module Name: myidct
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module myidct_less_lut(clk, rst, start, dct_2d, idct_2d, rdy);
output [7:0] idct_2d; 
output rdy;
input clk, rst, start; 
input[11:0] dct_2d; 
wire[7:0] idct_2d; 
wire rdy;

// loop counter
integer i;

// coifficients
reg signed [13:0] c0 [0:7] = {14'd5793, 14'd5793, 14'd5793, 14'd5793, 14'd5793, 14'd5793, 14'd5793, 14'd5793};
reg signed [13:0] c1 [0:7] = {14'd8035, 14'd6811, 14'd4551, 14'd1598, -14'd1598, -14'd4551, -14'd6811, -14'd8035};
reg signed [13:0] c2 [0:7] = {14'd7568, 14'd3135, -14'd3135, -14'd7568, -14'd7568, -14'd3135, 14'd3135, 14'd7568};
reg signed [13:0] c3 [0:7] = {14'd6811, -14'd1598, -14'd8035, -14'd4551, 14'd4551, 14'd8035, 14'd1598, -14'd6811};
reg signed [13:0] c4 [0:7] = {14'd5793, -14'd5793, -14'd5793, 14'd5793, 14'd5793, -14'd5793, -14'd5793, 14'd5793};
reg signed [13:0] c5 [0:7] = {14'd4551, -14'd8035, 14'd1598, 14'd6811, -14'd6811, -14'd1598, 14'd8035, -14'd4551};
reg signed [13:0] c6 [0:7] = {14'd3135, -14'd7568, 14'd7568, -14'd3135, -14'd3135, 14'd7568, -14'd7568, 14'd3135};
reg signed [13:0] c7 [0:7] = {14'd1598, -14'd4551, 14'd6811, -14'd8035, 14'd8035, -14'd6811, 14'd4551, -14'd1598};

// Memory to buffer first stage idct ooutput
reg [32:0] mem [0:63];
reg [32:0] dup_mem [0:63];
reg [5:0] mem_index;
// stage 2 memory read signals
reg [5:0] mem_index_2;
reg [5:0] mem_index_2_initial;
// emomry ready to be used or not
wire mem_rdy;
assign mem_rdy = (stage_1_cnt == 3'd0 & stage_1_cnt_valid == 1'b1) & (mem_index == 6'd56);

// counter to synchronize first stage operations
reg [2:0] stage_1_cnt;
reg [2:0] stage_1_cnt_i;
// set after count is changed
reg stage_1_cnt_valid; 
// when multiply stage produces an output
reg stage_1_i_valid; 

// input treated as signed instead of unisgned
reg signed [11:0] dct_2d_signed;
// output of stage 1
reg signed [32:0] stage_1 [0:7];
reg signed [32:0] stage_1_i [0:7];
// when first results from stage 1 are available
reg stage_1_rdy;


// stage 2 input
reg signed [32:0] stage_2_in;
// intermediate output of stage 2
reg signed [53:0] stage_2_i [0:7];
// output of stage 2
reg signed [53:0] stage_2 [0:7];
// counter to synchronize second stage operations
reg [2:0] stage_2_cnt;
reg [2:0] stage_2_cnt_i;
reg stage2_cnt_valid;
// when stage 2 intermediate is ready
reg stage_2_rdy_i;
// when stage 2 is ready
reg stage_2_rdy;

// output buffers
reg [53:0] output_buffer [0:7];
// intermediate outputs 
reg [53:0] output_i_0;
reg [25:0] output_i_1;
reg [25:0] output_i_2;
reg [7:0] output_i_3;
reg [8:0] output_i_4;
// final output
reg [7:0] output_final;

always @(posedge clk) begin
    if (rst) begin
        stage_1_cnt <= 3'd0;
        stage_1_cnt_valid <= 1'b0;
        stage_1_i_valid <= 1'b0;
        stage_1_cnt_i <= 3'd0;
    end
    else begin
        if (start) begin
            stage_1_cnt_i <= stage_1_cnt_i + 1;
            stage_1_i_valid <= 1'b1;
            if (stage_1_i_valid) begin
                stage_1_cnt <= stage_1_cnt + 1;
                stage_1_cnt_valid <= 1'b1;
            end
        end
    end
end

// implement first stage
always @(*) begin
    if (rst) begin
        dct_2d_signed <= 0;
    end
    else begin
        dct_2d_signed <= dct_2d;
    end
end


reg signed [13:0] cin_0 [0:7];
wire signed [32:0] mult_out_0 [0:7];

always @(*) begin
   for (i = 0; i < 8; i = i + 1) begin
       case(stage_1_cnt_i)
            0: cin_0[i] <= c0[i];
            1: cin_0[i] <= c1[i];
            2: cin_0[i] <= c2[i];
            3: cin_0[i] <= c3[i];
            4: cin_0[i] <= c4[i];
            5: cin_0[i] <= c5[i];
            6: cin_0[i] <= c6[i];
            7: cin_0[i] <= c7[i];
      endcase   
  end
end

mult_gen_1 mult_8(.P(mult_out_0[0]), .A(dct_2d_signed), .B(cin_0[0]));
mult_gen_1 mult_9(.P(mult_out_0[1]), .A(dct_2d_signed), .B(cin_0[1]));
mult_gen_1 mult_10(.P(mult_out_0[2]), .A(dct_2d_signed), .B(cin_0[2]));
mult_gen_1 mult_11(.P(mult_out_0[3]), .A(dct_2d_signed), .B(cin_0[3]));
mult_gen_1 mult_12(.P(mult_out_0[4]), .A(dct_2d_signed), .B(cin_0[4]));
mult_gen_1 mult_13(.P(mult_out_0[5]), .A(dct_2d_signed), .B(cin_0[5]));
mult_gen_1 mult_14(.P(mult_out_0[6]), .A(dct_2d_signed), .B(cin_0[6]));
mult_gen_1 mult_15(.P(mult_out_0[7]), .A(dct_2d_signed), .B(cin_0[7]));

always @(posedge clk) begin
   for (i = 0; i < 8; i = i + 1) begin
       if (rst) begin
            stage_1_i[i] <= 0;
        end
        else if (start) begin
            stage_1_i[i] <= mult_out_0[i];
        end
    end
end

always @(posedge clk) begin
   for (i = 0; i < 8; i = i + 1) begin
       if (rst) begin
            stage_1[i] <= 0;
        end
        else if (start && stage_1_i_valid) begin
            case(stage_1_cnt)
                0: stage_1[i] <= stage_1_i[i];
                1: stage_1[i] <= stage_1_i[i] + stage_1[i];
                2: stage_1[i] <= stage_1_i[i] + stage_1[i];
                3: stage_1[i] <= stage_1_i[i] + stage_1[i];
                4: stage_1[i] <= stage_1_i[i] + stage_1[i];
                5: stage_1[i] <= stage_1_i[i] + stage_1[i];
                6: stage_1[i] <= stage_1_i[i] + stage_1[i];
                7: stage_1[i] <= stage_1_i[i] + stage_1[i];
              endcase
        end
    end
end

// update memory after 8 input items have been passed in
always @(posedge clk) begin
    if (rst) begin
        mem_index <= 6'd0;
        stage_1_rdy <= 0;
    end
    else begin
        if (start) begin
            if (stage_1_cnt == 3'd0 && stage_1_cnt_valid == 1'b1) begin
                for (i = 0; i < 8; i = i + 1) begin
                    mem[mem_index + i] <= stage_1[i];
                end
                mem_index <= mem_index + 8;

                if (mem_rdy) begin
                    mem_index <= 6'd0;
                    stage_1_rdy <= 1'b1;
                end
              end
         end
    end
end

reg mem_rdy_d;
always @(posedge clk) begin
    if (rst) begin
        mem_rdy_d <= 1'b0;
    end else begin
        if (start) begin
            mem_rdy_d <= mem_rdy;
        end
    end
end

always @(posedge clk) begin
    if (start && mem_rdy_d) begin
        for (i = 0; i < 64; i = i + 1) begin
            dup_mem[i] <= mem[i];
        end
    end
end

// Controller to feed stage2 with data
always @(posedge clk) begin
    if (rst) begin
        stage_2_in <= 0;
        mem_index_2 <= 0;
        mem_index_2_initial <= 1;
    end else begin
        if (start && mem_rdy) begin
            stage_2_in <= mem[0];   // take first one from normal memory
            mem_index_2 <= 8;
            mem_index_2_initial <= 1;
        end else begin
            if (start && stage_1_rdy) begin
                if (mem_index_2 == 8) begin
                    stage_2_in <= mem[mem_index_2];
                end else begin
                    stage_2_in <= dup_mem[mem_index_2];
                end
                if (mem_index_2[5:3] == 3'b111) begin
                    mem_index_2 <= mem_index_2_initial;
                    mem_index_2_initial <= mem_index_2_initial + 1;
                end else begin
                    mem_index_2 <= mem_index_2 + 8;
                end
            end
        end
    end
end

// 2nd stage counter update and ready signal processing
always @(posedge clk) begin
    if (rst) begin
        stage_2_cnt <= 3'd0;
        stage_2_rdy <= 1'b0;
        stage2_cnt_valid <= 1'b0;
        stage_2_rdy_i <= 1'b0;
        stage_2_cnt_i <= 3'd0;
    end
    else begin
        if (start && stage_1_rdy) begin
            stage_2_rdy_i <= 1'b1;
            stage_2_cnt_i <= stage_2_cnt_i + 1;
        end
        if (start && stage_2_rdy_i) begin
            stage_2_cnt <= stage_2_cnt + 1;
            stage2_cnt_valid <= 1'b1;
            if (stage_2_cnt == 3'd0 && stage2_cnt_valid == 1'b1) begin
                stage_2_rdy <= 1'b1;
            end
        end
    end
end

// 2nd stage intermediate processing
reg signed [13:0] cin [0:7];
wire signed [53:0] mult_out [0:7];

always @(*) begin
   for (i = 0; i < 8; i = i + 1) begin
       case(stage_2_cnt_i)
            0: cin[i] <= c0[i];
            1: cin[i] <= c1[i];
            2: cin[i] <= c2[i];
            3: cin[i] <= c3[i];
            4: cin[i] <= c4[i];
            5: cin[i] <= c5[i];
            6: cin[i] <= c6[i];
            7: cin[i] <= c7[i];
      endcase   
  end
end

mult_gen_0 mult_0(.P(mult_out[0]), .A(stage_2_in), .B(cin[0]));
mult_gen_0 mult_1(.P(mult_out[1]), .A(stage_2_in), .B(cin[1]));
mult_gen_0 mult_2(.P(mult_out[2]), .A(stage_2_in), .B(cin[2]));
mult_gen_0 mult_3(.P(mult_out[3]), .A(stage_2_in), .B(cin[3]));
mult_gen_0 mult_4(.P(mult_out[4]), .A(stage_2_in), .B(cin[4]));
mult_gen_0 mult_5(.P(mult_out[5]), .A(stage_2_in), .B(cin[5]));
mult_gen_0 mult_6(.P(mult_out[6]), .A(stage_2_in), .B(cin[6]));
mult_gen_0 mult_7(.P(mult_out[7]), .A(stage_2_in), .B(cin[7]));

always @(posedge clk) begin
   for (i = 0; i < 8; i = i + 1) begin
       if (rst) begin
            stage_2_i[i] <= 0;
        end
        else if (start && stage_1_rdy) begin
            stage_2_i[i] <= mult_out[i];
        end
    end
end

// 2nd stage adder processing
always @(posedge clk) begin
   for (i = 0; i < 8; i = i + 1) begin
       if (rst) begin
            stage_2[i] <= 0;
        end
        else if (start && stage_2_rdy_i) begin
            case(stage_2_cnt)
                0: stage_2[i] <= stage_2_i[i];
                1: stage_2[i] <= stage_2_i[i] + stage_2[i];
                2: stage_2[i] <= stage_2_i[i] + stage_2[i];
                3: stage_2[i] <= stage_2_i[i] + stage_2[i];
                4: stage_2[i] <= stage_2_i[i] + stage_2[i];
                5: stage_2[i] <= stage_2_i[i] + stage_2[i];
                6: stage_2[i] <= stage_2_i[i] + stage_2[i];
                7: stage_2[i] <= stage_2_i[i] + stage_2[i];
              endcase
        end
    end
end

always @(posedge clk) begin
    for (i = 0; i < 8; i = i + 1) begin
        if (rst) begin
            output_buffer[i] <= 0;
        end
        else begin
            if (start && stage_2_cnt == 3'd0 && stage2_cnt_valid == 1'b1)  begin
                output_buffer[i] <= stage_2[i];
            end
        end
    end
end

always @(*) begin
    if (rst) begin
        output_final <= 0;
        output_i_0 <= 0;
        output_i_1 <= 0;
        output_i_2 <= 0;
        output_i_3 <= 0;
        output_i_4 <= 0;
    end
    else begin
        if (start) begin
            output_i_0 = output_buffer[stage_2_cnt-3'b1];
            output_i_1 = (output_i_0[53] == 1) ? ~((~output_i_0+1)>>28)+1 : output_i_0>>28;
            output_i_2 = (output_i_1[25] == 1) ? ~output_i_1+1 : output_i_1;
            // These next 3 lines are not well tested
            output_i_3 = (|(output_i_2[25:7]) ? (output_i_1[25] == 1 ? -8'd128 : 8'd127) : output_i_1[7:0]);
            output_i_4 = {output_i_3[7], output_i_3} + 9'd128;
            output_final = output_i_4[7:0];
        end
    end
end

assign rdy = stage_2_rdy & start;
assign idct_2d =  output_final &  {8{rdy}};

endmodule
