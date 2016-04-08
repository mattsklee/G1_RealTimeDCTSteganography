`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2016 11:12:16 AM
// Design Name: 
// Module Name: new_tb
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


module sim_with_bram_tb (

    );

  logic clk_500;
  logic reset;
  logic stego_clk;
  logic stego_reset;
  logic encoder_1_decoder_0;

  parameter NUM_COLS = 128;
  parameter NUM_ROWS = 4;

  parameter integer C_M00_AXI_BURST_LEN   = 128;
  parameter integer C_M00_AXI_ID_WIDTH    = 1;
  parameter integer C_M00_AXI_ADDR_WIDTH  = 32;
  parameter integer C_M00_AXI_DATA_WIDTH  = 32;
  parameter integer C_M00_AXI_AWUSER_WIDTH  = 0;
  parameter integer C_M00_AXI_ARUSER_WIDTH  = 0;
  parameter integer C_M00_AXI_WUSER_WIDTH = 0;
  parameter integer C_M00_AXI_RUSER_WIDTH = 0;
  parameter integer C_M00_AXI_BUSER_WIDTH = 0;

  // Ports of Axi Master Bus Interface M00_AXI
  wire  m00_axi_error, m00_axi_error_e, m00_axi_error_d;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid, m00_axi_awid_e, m00_axi_awid_d;
  wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr, m00_axi_awaddr_e, m00_axi_awaddr_d;
  wire [7 : 0] m00_axi_awlen, m00_axi_awlen_e, m00_axi_awlen_d;
  wire [2 : 0] m00_axi_awsize, m00_axi_awsize_e, m00_axi_awsize_d;
  wire [1 : 0] m00_axi_awburst, m00_axi_awburst_e, m00_axi_awburst_d;
  wire  m00_axi_awvalid, m00_axi_awvalid_e, m00_axi_awvalid_d;
  wire  m00_axi_awready;
  wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata, m00_axi_wdata_e, m00_axi_wdata_d;
  wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb, m00_axi_wstrb_e, m00_axi_wstrb_d;
  wire  m00_axi_wlast, m00_axi_wlast_e, m00_axi_wlast_d;
  wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser;
  wire  m00_axi_wvalid, m00_axi_wvalid_e, m00_axi_wvalid_d;
  wire  m00_axi_wready;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid;
  wire [1 : 0] m00_axi_bresp;
  wire  m00_axi_bvalid, m00_axi_bvalid_e, m00_axi_bvalid_d;
  wire  m00_axi_bready, m00_axi_bready_e, m00_axi_bready_d;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid;
  wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr, m00_axi_araddr_e, m00_axi_araddr_d;
  wire [7 : 0] m00_axi_arlen, m00_axi_arlen_e, m00_axi_arlen_d;
  wire [2 : 0] m00_axi_arsize, m00_axi_arsize_e, m00_axi_arsize_d;
  wire [1 : 0] m00_axi_arburst, m00_axi_arburst_e, m00_axi_arburst_d;
  wire  m00_axi_arvalid, m00_axi_arvalid_e, m00_axi_arvalid_d;
  wire  m00_axi_arready;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid;
  wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata;
  wire [1 : 0] m00_axi_rresp;
  wire  m00_axi_rlast;
  wire  m00_axi_rvalid, m00_axi_rvalid_e, m00_axi_rvalid_d;
  wire  m00_axi_rready, m00_axi_rready_e, m00_axi_rready_d;

encoder_top #(
  .NUM_COLS ( NUM_COLS ),
  .NUM_ROWS ( NUM_ROWS )
) encoder (
  .axi_clk      ( clk_500 ),
  .axi_resetn   ( ~reset  ),
  .encoder_clk  ( stego_clk ),
  .encoder_reset  ( stego_reset ),
  .m00_axi_error (m00_axi_error_e),
  .m00_axi_awid (m00_axi_awid_e),
  .m00_axi_awaddr (m00_axi_awaddr_e),
  .m00_axi_awlen (m00_axi_awlen_e),
  .m00_axi_awsize (m00_axi_awsize_e),
  .m00_axi_awburst (m00_axi_awburst_e),
  .m00_axi_awvalid (m00_axi_awvalid_e),
  .m00_axi_awready (m00_axi_awready),
  .m00_axi_wdata (m00_axi_wdata_e),
  .m00_axi_wstrb (m00_axi_wstrb_e),
  .m00_axi_wlast (m00_axi_wlast_e),
  .m00_axi_wvalid (m00_axi_wvalid_e),
  .m00_axi_wready (m00_axi_wready),
  .m00_axi_bid (m00_axi_bid),
  .m00_axi_bresp (m00_axi_bresp),
  .m00_axi_bvalid (m00_axi_bvalid_e),
  .m00_axi_bready (m00_axi_bready_e),
  .m00_axi_araddr (m00_axi_araddr_e),
  .m00_axi_arlen (m00_axi_arlen_e),
  .m00_axi_arsize (m00_axi_arsize_e),
  .m00_axi_arburst (m00_axi_arburst_e),
  .m00_axi_arvalid (m00_axi_arvalid_e),
  .m00_axi_arready (m00_axi_arready),
  .m00_axi_rid (m00_axi_rid),
  .m00_axi_rdata (m00_axi_rdata),
  .m00_axi_rresp (m00_axi_rresp),
  .m00_axi_rlast (m00_axi_rlast),
  .m00_axi_rvalid (m00_axi_rvalid_e),
  .m00_axi_rready (m00_axi_rready_e)
);


decoder_top #(
  .NUM_COLS ( NUM_COLS ),
  .NUM_ROWS ( NUM_ROWS )
) decoder (
  .axi_clk      ( clk_500 ),
  .axi_resetn   ( ~reset  ),
  .decoder_clk  ( stego_clk ),
  .decoder_reset  ( stego_reset ),
  .m00_axi_error (m00_axi_error_d),
  .m00_axi_awid (m00_axi_awid_d),
  .m00_axi_awaddr (m00_axi_awaddr_d),
  .m00_axi_awlen (m00_axi_awlen_d),
  .m00_axi_awsize (m00_axi_awsize_d),
  .m00_axi_awburst (m00_axi_awburst_d),
  .m00_axi_awvalid (m00_axi_awvalid_d),
  .m00_axi_awready (m00_axi_awready), ///
  .m00_axi_wdata (m00_axi_wdata_d),
  .m00_axi_wstrb (m00_axi_wstrb_d),
  .m00_axi_wlast (m00_axi_wlast_d),
  .m00_axi_wvalid (m00_axi_wvalid_d),
  .m00_axi_wready (m00_axi_wready), ///
  .m00_axi_bid (m00_axi_bid), ///
  .m00_axi_bresp (m00_axi_bresp), ///
  .m00_axi_bvalid (m00_axi_bvalid_d), ///
  .m00_axi_bready (m00_axi_bready_d),
  .m00_axi_araddr (m00_axi_araddr_d),
  .m00_axi_arlen (m00_axi_arlen_d),
  .m00_axi_arsize (m00_axi_arsize_d),
  .m00_axi_arburst (m00_axi_arburst_d),
  .m00_axi_arvalid (m00_axi_arvalid_d),
  .m00_axi_arready (m00_axi_arready), ///
  .m00_axi_rid (m00_axi_rid), ///
  .m00_axi_rdata (m00_axi_rdata), ///
  .m00_axi_rresp (m00_axi_rresp), ///
  .m00_axi_rlast (m00_axi_rlast), ///
  .m00_axi_rvalid (m00_axi_rvalid_d), ///
  .m00_axi_rready (m00_axi_rready_d)
);

assign m00_axi_error   = (encoder_1_decoder_0 == 1) ? m00_axi_error_e   : m00_axi_error_d;
assign m00_axi_awid    = (encoder_1_decoder_0 == 1) ? m00_axi_awid_e    : m00_axi_awid_d;
assign m00_axi_awaddr  = (encoder_1_decoder_0 == 1) ? m00_axi_awaddr_e  : m00_axi_awaddr_d;
assign m00_axi_awlen   = (encoder_1_decoder_0 == 1) ? m00_axi_awlen_e   : m00_axi_awlen_d;
assign m00_axi_awsize  = (encoder_1_decoder_0 == 1) ? m00_axi_awsize_e  : m00_axi_awsize_d;
assign m00_axi_awburst = (encoder_1_decoder_0 == 1) ? m00_axi_awburst_e : m00_axi_awburst_d;
assign m00_axi_awvalid = (encoder_1_decoder_0 == 1) ? m00_axi_awvalid_e : m00_axi_awvalid_d;
assign m00_axi_wdata   = (encoder_1_decoder_0 == 1) ? m00_axi_wdata_e   : m00_axi_wdata_d;
assign m00_axi_wstrb   = (encoder_1_decoder_0 == 1) ? m00_axi_wstrb_e   : m00_axi_wstrb_d;
assign m00_axi_wlast   = (encoder_1_decoder_0 == 1) ? m00_axi_wlast_e   : m00_axi_wlast_d;
assign m00_axi_wvalid  = (encoder_1_decoder_0 == 1) ? m00_axi_wvalid_e  : m00_axi_wvalid_d;
assign m00_axi_bready  = (encoder_1_decoder_0 == 1) ? m00_axi_bready_e  : m00_axi_bready_d;
assign m00_axi_araddr  = (encoder_1_decoder_0 == 1) ? m00_axi_araddr_e  : m00_axi_araddr_d;
assign m00_axi_arlen   = (encoder_1_decoder_0 == 1) ? m00_axi_arlen_e   : m00_axi_arlen_d;
assign m00_axi_arsize  = (encoder_1_decoder_0 == 1) ? m00_axi_arsize_e  : m00_axi_arsize_d;
assign m00_axi_arburst = (encoder_1_decoder_0 == 1) ? m00_axi_arburst_e : m00_axi_arburst_d;
assign m00_axi_arvalid = (encoder_1_decoder_0 == 1) ? m00_axi_arvalid_e : m00_axi_arvalid_d;
assign m00_axi_rready  = (encoder_1_decoder_0 == 1) ? m00_axi_rready_e  : m00_axi_rready_d;

// Valid signals
assign m00_axi_bvalid_e = (encoder_1_decoder_0 == 1) ? m00_axi_bvalid : 1'b0;
assign m00_axi_bvalid_d = (encoder_1_decoder_0 == 0) ? m00_axi_bvalid : 1'b0;
assign m00_axi_rvalid_e = (encoder_1_decoder_0 == 1) ? m00_axi_rvalid : 1'b0;
assign m00_axi_rvalid_d = (encoder_1_decoder_0 == 0) ? m00_axi_rvalid : 1'b0;


blk_mem_gen_0 bram (
  .s_aclk (clk_500),
  .s_aresetn (~reset),
  .s_axi_awid (m00_axi_awid),
  .s_axi_awaddr ({20'b0, m00_axi_awaddr[11:0]}),
  .s_axi_awlen (m00_axi_awlen),
  .s_axi_awsize (m00_axi_awsize),
  .s_axi_awburst (m00_axi_awburst),
  .s_axi_awvalid (m00_axi_awvalid),
  .s_axi_awready (m00_axi_awready),
  .s_axi_wdata (m00_axi_wdata),
  .s_axi_wstrb (m00_axi_wstrb),
  .s_axi_wlast (m00_axi_wlast),
  .s_axi_wvalid (m00_axi_wvalid),
  .s_axi_wready (m00_axi_wready),
  .s_axi_bid (m00_axi_bid),
  .s_axi_bresp (m00_axi_bresp),
  .s_axi_bvalid (m00_axi_bvalid),
  .s_axi_bready (m00_axi_bready),
  .s_axi_arid (m00_axi_arid),
  .s_axi_araddr ({20'b0, m00_axi_araddr[11:0]}),
  .s_axi_arlen (m00_axi_arlen),
  .s_axi_arsize (m00_axi_arsize),
  .s_axi_arburst (m00_axi_arburst),
  .s_axi_arvalid (m00_axi_arvalid),
  .s_axi_arready (m00_axi_arready),
  .s_axi_rid (m00_axi_rid),
  .s_axi_rdata (m00_axi_rdata),
  .s_axi_rresp (m00_axi_rresp),
  .s_axi_rlast (m00_axi_rlast),
  .s_axi_rvalid (m00_axi_rvalid),
  .s_axi_rready (m00_axi_rready)
);

// Drive 500 MHz clock
initial         clk_500  <= 1'b0;
always  #1      clk_500  <= ~clk_500;

initial         stego_clk <= 1'b1;
always  #0.5      stego_clk  <= ~stego_clk;


// Power On reset pulse.
initial begin
  $display("INFO: Reset high.");
  reset   <= 1'b1;
  stego_reset <= 1'b1;
  encoder_1_decoder_0 <= 1'b1;
  #101;
  $display("INFO: Reset low.");
  reset   <= 1'b0;
  stego_reset <= 1'b0;
  force encoder.msg_baddr =  32'h000000000;
  force encoder.cimg_baddr = 32'h000000000;
  force encoder.simg_baddr = 32'h000000800;
  force decoder.msg_baddr =  32'h00000000c;
  force decoder.simg_baddr = 32'h000000800;
  #100;
  force encoder.begin_encoding = 1'b1;
  #2;
  force encoder.begin_encoding = 1'b0;
  while (!encoder.done_encoding) begin
    #2;
  end
  #100;
  encoder_1_decoder_0 <= 1'b0;
  force decoder.begin_decoding = 1'b1;
  #2;
  force decoder.begin_decoding = 1'b0;
  while (decoder.msg_outfifo.empty) begin
    #2;
  end
  #10000;
  force decoder.msg_outfifo_has_enough_data = 1'b1;
  #12;
  force decoder.msg_outfifo_has_enough_data = 1'b0;
end


endmodule
