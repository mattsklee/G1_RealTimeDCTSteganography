`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2016 02:02:25 PM
// Design Name: 
// Module Name: mdct_myidct
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


module stego_encode(clk, rst, start, message, data_in, data_out, rdy);
output [7:0] data_out; 
output rdy;
input clk, rst, start, message; 
input [7:0] data_in; 

wire rdy;
wire [7:0] data_out;

wire [11:0] dct;
wire rdy_i;

// 1/18*4096
reg signed [8:0] Q_1 = {9'd228};
// 18*4096
reg signed [5:0] Q_2 = {6'd18};
// signed intermediate input
reg signed [11:0] dct_signed;
reg signed [11:0] dct_signed_2;

reg signed [20:0] dct_q_i_0;
reg signed [20:0] dct_q_i_1;
reg signed [8:0] dct_q_i_2;
reg signed [8:0] dct_q_i_3;
// qunatized dct coifficient
reg signed [8:0] dct_q;

reg signed [8:0] data_out_i_0;
reg signed [14:0] data_out_i_1;
reg signed [14:0] data_out_i_2;
reg signed [11:0] data_out_i_3;
reg signed [11:0] data_out_i_4;
reg signed [11:0] data_out_i;

// counter of time
reg [5:0] cnt_t;

reg [12:0] start_on_count;
reg start_force, start_forced;
reg start_went_on;

// Msg fifo things
reg [5:0] start_cnt;
reg [5:0] rdy_cnt;
wire wr_en, rd_en;
reg msg_embed;
reg [2:0] wr_bit;
reg [2:0] rd_bit;
reg [7:0] msg_fifo;

always @(posedge clk) begin
    if (rst) begin
        start_on_count <= 0;
        start_went_on <= 0;
    end
    else begin
        if (start) begin
           start_on_count <= 0;
           start_went_on <= 1;
        end
        if (~start && start_went_on && ~start_forced) begin
           start_on_count <= start_on_count + 1; 
        end
    end
end
always @(posedge clk) begin
    if (rst) begin
        start_force <= 0;
        start_forced <= 0;
    end else begin
        if (start_on_count >= 11'd1000 && start_on_count <= 11'd1128) begin
            start_force <= 1;
        end else begin 
            start_force <= 0;
        end
        if (start_on_count == 11'd1128) begin
            start_forced <= 1;
        end else begin
            start_forced <= start_forced;
        end
    end
end


reg [2:0] rdy_i_d;
always @(posedge clk) begin
    if (rst) begin
        rdy_i_d <= 0;
    end else begin
        rdy_i_d <= {rdy_i_d[1:0], rdy_i};
    end
end


always @(posedge clk) begin
    if (rst) begin
        cnt_t <= 0;
    end
    else begin
        if (rdy_i_d[0]) begin
            cnt_t <= cnt_t + 1;
        end
    end
end

// Pipeline stage 1
always @(*) begin
   dct_q_i_0 = dct_signed*Q_1;
   dct_q_i_1 = dct_q_i_0[20] == 1 ? ~dct_q_i_0+1 : dct_q_i_0;
   dct_q_i_2 = dct_q_i_1[11] == 1 ?  dct_q_i_1[20:12]+12'd1 : dct_q_i_1[20:12];
   dct_q_i_3 = dct_q_i_0[20] == 1 ? ~dct_q_i_2+1 : dct_q_i_2;
end


// Pipeline stage 2
always @(*) begin
   data_out_i_0 = dct_q;
   data_out_i_0[0] = msg_embed;
   data_out_i_1 = data_out_i_0*Q_2;
   data_out_i_2 = (data_out_i_1[14] == 1) ? ~data_out_i_1+1 : data_out_i_1;
   data_out_i_3 = (|(data_out_i_2[14:11]) ? (data_out_i_1[14] == 1 ? -12'd2048 : 12'd2047) : data_out_i_2[11:0]);
   data_out_i_4 = (data_out_i_1[14] == 1) ? ~data_out_i_3+1 : data_out_i_3;
end

reg rdy_debug;
always @(posedge clk) begin
    if (rst) begin
        dct_signed <= 0;
        dct_signed_2 <= 0;
        data_out_i <= 0;
        dct_q <= 0;
        rdy_debug <= 0;
    end
    else begin
        // Pipeline stage 1
        if (rdy_i) begin
            dct_signed <= dct;
        end

        // Pipeline stage 2
        if (rdy_i_d[0]) begin
            dct_q <= dct_q_i_3;
            dct_signed_2 <= dct_signed;
        end
        
        // Pipeline stage 3
        if (rdy_i_d[1]) begin
            data_out_i <= (cnt_t == 6'd43 ? data_out_i_4 : dct_signed_2);
            if (cnt_t == 6'd43) begin
                rdy_debug <= 1;
            end
            else begin
                rdy_debug <= 0;
            end
        end
    end
end



always @(posedge clk) begin
    if (rst) begin
        start_cnt <= 0;
        rdy_cnt <= 0;
    end else begin
        if (start) begin
            start_cnt <= start_cnt + 1'b1;
        end
        if (rdy_i) begin
            rdy_cnt <= rdy_cnt + 1'b1;
        end
    end
end

assign wr_en = ((start_cnt == 0) && start);
assign rd_en = ((rdy_cnt == 0) && rdy_i);

always @(posedge clk) begin
    if (rst) begin
        wr_bit <= 0;
        rd_bit <= 0;
        msg_fifo <= 0;
        msg_embed <= 0;
    end else begin
        if (wr_en) begin
            wr_bit <= wr_bit + 1'b1;
            msg_fifo[wr_bit] <= message;
        end
        if (rd_en) begin
            rd_bit <= rd_bit + 1'b1;
            msg_embed <= msg_fifo[rd_bit];
        end
    end
end




MDCT dct_1 (.clk(clk), .rst(rst), .dcti(data_in), .idv(start), .odv(rdy_i), .dcto(dct));
myidct_less_lut idct_1 (.clk(clk), .rst(rst), .dct_2d(data_out_i), .start( rdy_i_d[2]|start_force), .rdy(rdy), .idct_2d(data_out));

endmodule
