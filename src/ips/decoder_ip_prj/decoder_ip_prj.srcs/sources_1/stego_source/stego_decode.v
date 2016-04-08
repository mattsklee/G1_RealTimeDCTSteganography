`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2016 02:44:49 PM
// Design Name: 
// Module Name: stego_decode
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


module stego_decode(clk, rst, start, data_in, message, rdy);
output rdy, message;
input clk, rst, start; 
input [7:0] data_in; 

wire rdy;
wire message;

wire [11:0] dct;
// asserted when dct is ready
wire rdy_i;
// dct out signal delayed by one
reg rdy_i_d1;
// dct out signal delyed by two
reg rdy_i_d2;
// dct out signal delayed by three
reg rdy_i_d3;

reg signed [8:0] Q_1 = {9'd228};
reg signed [11:0] dct_signed;

reg signed [20:0] dct_q_i_0;
reg signed [20:0] dct_q_i_1;
reg signed [8:0] dct_q_i_2;
reg signed [8:0] dct_q_i_3;
// qunatized dct coifficient
reg signed [8:0] dct_q;

reg signed  data_out;

reg data_out_rdy;

// counter of input blocks
reg [5:0] cnt;

reg [18:0] lfsr_1;
reg [21:0] lfsr_2;
reg [22:0] lfsr_3;
wire lfsr_out;

always @(posedge clk) begin
    if (rst) begin
        rdy_i_d1 <= 0;
        rdy_i_d2 <= 0;
        rdy_i_d3 <= 0;
    end
    else begin
        rdy_i_d1 <= rdy_i; 
        rdy_i_d2 <= rdy_i_d1;
        rdy_i_d3 <= rdy_i_d2;
    end
end

always @(*) begin
   dct_q_i_0 = dct_signed*Q_1;
   dct_q_i_1 = dct_q_i_0[20] == 1 ? ~dct_q_i_0+1 : dct_q_i_0;
   dct_q_i_2 = dct_q_i_1[11] == 1 ?  dct_q_i_1[20:12]+12'd1 : dct_q_i_1[20:12];
   dct_q_i_3 = dct_q_i_0[20] == 1 ? ~dct_q_i_2+1 : dct_q_i_2;
end

always @(posedge clk) begin
    if (rst) begin
        dct_signed <= 0;
    end
    else begin
        if (rdy_i) begin
            dct_signed <= dct;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        dct_q <= 0;
    end
    else begin
        if (rdy_i_d1) begin
            dct_q <= dct_q_i_3;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        cnt <= 0;
    end
    else begin
        if (rdy_i_d2) begin
            cnt <= cnt + 1;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        data_out <= 0;
        data_out_rdy <= 0;
    end
    else begin
        if (rdy_i_d2) begin
            if (cnt == 6'd42) begin
                data_out_rdy <= 1;
            end
            else begin
                data_out_rdy <= 0;
            end
            data_out <= (cnt == 6'd42 ? dct_q[0]^lfsr_out : 1'b0);
        end
    end
end

assign message = data_out;
assign rdy = data_out_rdy;

assign lfsr_out = lfsr_1[18] ^ lfsr_2[21] ^ lfsr_3[22]; 
always @(posedge clk) begin
    if (rst) begin
        lfsr_1 <= 19'd1876;
        lfsr_2 <= 22'd20007;
        lfsr_3 <= 23'd14376;
    end
    else begin
        if (rdy) begin
            lfsr_1 <= {lfsr_1[17:0], lfsr_1[18]^lfsr_1[17]^lfsr_1[16]^lfsr_1[13]};
            lfsr_2 <= {lfsr_2[20:0], lfsr_2[21]^lfsr_2[20]};
            lfsr_3 <= {lfsr_3[21:0], lfsr_3[22]^lfsr_3[21]^lfsr_3[20]^lfsr_3[7]};
        end
    end
end


MDCT dct_5 (.clk(clk), .rst(rst), .dcti(data_in), .idv(start), .odv(rdy_i), .dcto(dct));

endmodule
