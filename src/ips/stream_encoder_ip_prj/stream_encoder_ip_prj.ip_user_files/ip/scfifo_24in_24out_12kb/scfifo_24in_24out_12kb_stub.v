// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Wed Mar 30 14:52:13 2016
// Host        : DESKTOP-5FTSDRT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/SKL/Desktop/ECE532/repo/streamed_encoder_ip_prj2/project_1.runs/scfifo_24in_24out_12kb_synth_1/scfifo_24in_24out_12kb_stub.v
// Design      : scfifo_24in_24out_12kb
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_0_0,Vivado 2015.3" *)
module scfifo_24in_24out_12kb(clk, rst, din, wr_en, rd_en, dout, full, empty, data_count)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,din[23:0],wr_en,rd_en,dout[23:0],full,empty,data_count[0:0]" */;
  input clk;
  input rst;
  input [23:0]din;
  input wr_en;
  input rd_en;
  output [23:0]dout;
  output full;
  output empty;
  output [0:0]data_count;
endmodule
