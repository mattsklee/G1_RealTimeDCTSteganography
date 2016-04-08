`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2016 10:05:53 PM
// Design Name: 
// Module Name: sim
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


module sim(

    );

  logic clk, reset;

  logic [23:0] s00_axis_tdata;
  logic s00_axis_tlast, s00_axis_tvalid;
  wire s00_axis_tready;
  
  wire m00_axis_tvalid, m00_axis_tlast;
  wire [23:0] m00_axis_tdata;
  logic  m00_axis_tready;

    
stream_encoder_top dut ( 
    .clk, .reset,
    .s00_axis_tdata, .s00_axis_tlast, .s00_axis_tvalid, .s00_axis_tready,
    .m00_axis_tvalid, .m00_axis_tlast, .m00_axis_tdata, .m00_axis_tready
);


// Drive 100 MHz clock
initial         clk  <= 1'b1;
always  #5      clk  <= ~clk;

initial m00_axis_tready = 1'b1;
initial begin
  s00_axis_tvalid <= 1'b0;
  #220;
  s00_axis_tvalid <= 1'b1;
  #20;
  s00_axis_tvalid <= 1'b0;
  #30;
  s00_axis_tvalid <= 1'b1;
  while (1) begin
    #30;
    s00_axis_tvalid <= ~s00_axis_tvalid;
  end
end

initial begin
  s00_axis_tlast <= 1'b0;
  #330;
  s00_axis_tlast <= 1'b1;
  #10;
  s00_axis_tlast <= 1'b0;
end

initial begin
  s00_axis_tdata <= 24'hABCDEF;
  #330;
  s00_axis_tdata <= 24'hF1337F;
  #10;
  s00_axis_tdata <= 24'hBADF0D;
end

// Power On reset pulse.
initial begin
  $display("INFO: Reset high.");
  reset   <= 1'b1;
  #100;
  $display("INFO: Reset low.");
  reset   <= 1'b0;
end

endmodule
