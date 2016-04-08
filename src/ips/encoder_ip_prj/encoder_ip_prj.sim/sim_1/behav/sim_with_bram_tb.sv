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
  logic encoder_clk;
  logic encoder_reset;

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
  wire  m00_axi_error;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid;
  wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr;
  wire [7 : 0] m00_axi_awlen;
  wire [2 : 0] m00_axi_awsize;
  wire [1 : 0] m00_axi_awburst;
//  wire  m00_axi_awlock;
//  wire [3 : 0] m00_axi_awcache;
//  wire [2 : 0] m00_axi_awprot;
//  wire [3 : 0] m00_axi_awqos;
//  wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser;
  wire  m00_axi_awvalid;
  wire  m00_axi_awready;
  wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata;
  wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb;
  wire  m00_axi_wlast;
  wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser;
  wire  m00_axi_wvalid;
  wire  m00_axi_wready;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid;
  wire [1 : 0] m00_axi_bresp;
//  wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser;
  wire  m00_axi_bvalid;
  wire  m00_axi_bready;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid;
  wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr;
  wire [7 : 0] m00_axi_arlen;
  wire [2 : 0] m00_axi_arsize;
  wire [1 : 0] m00_axi_arburst;
//  wire  m00_axi_arlock;
//  wire [3 : 0] m00_axi_arcache;
//  wire [2 : 0] m00_axi_arprot;
//  wire [3 : 0] m00_axi_arqos;
//  wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser;
  wire  m00_axi_arvalid;
  wire  m00_axi_arready;
  wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid;
  wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata;
  wire [1 : 0] m00_axi_rresp;
  wire  m00_axi_rlast;
//  wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser;
  wire  m00_axi_rvalid;
  wire  m00_axi_rready;

encoder_top #(
  .NUM_COLS ( 128 ),
  .NUM_ROWS ( 4 )
) dut (
  .axi_clk      ( clk_500 ),
  .axi_resetn   ( ~reset  ),
  .encoder_clk  ( encoder_clk ),
  .encoder_reset  ( encoder_reset ),
    .m00_axi_error (m00_axi_error),
    .m00_axi_awid (m00_axi_awid),
    .m00_axi_awaddr (m00_axi_awaddr),
    .m00_axi_awlen (m00_axi_awlen),
    .m00_axi_awsize (m00_axi_awsize),
    .m00_axi_awburst (m00_axi_awburst),
//    .m00_axi_awlock (m00_axi_awlock),
//    .m00_axi_awcache (m00_axi_awcache),
//    .m00_axi_awprot (m00_axi_awprot),
//    .m00_axi_awqos (m00_axi_awqos),
//    .m00_axi_awuser (m00_axi_awuser),
    .m00_axi_awvalid (m00_axi_awvalid),
    .m00_axi_awready (m00_axi_awready),
    .m00_axi_wdata (m00_axi_wdata),
    .m00_axi_wstrb (m00_axi_wstrb),
    .m00_axi_wlast (m00_axi_wlast),
//    .m00_axi_wuser (m00_axi_wuser),
    .m00_axi_wvalid (m00_axi_wvalid),
    .m00_axi_wready (m00_axi_wready),
    .m00_axi_bid (m00_axi_bid),
    .m00_axi_bresp (m00_axi_bresp),
//    .m00_axi_buser (m00_axi_buser),
    .m00_axi_bvalid (m00_axi_bvalid),
    .m00_axi_bready (m00_axi_bready),
//    .m00_axi_arid (m00_axi_arid),
    .m00_axi_araddr (m00_axi_araddr),
    .m00_axi_arlen (m00_axi_arlen),
    .m00_axi_arsize (m00_axi_arsize),
    .m00_axi_arburst (m00_axi_arburst),
//    .m00_axi_arlock (m00_axi_arlock),
//    .m00_axi_arcache (m00_axi_arcache),
//    .m00_axi_arprot (m00_axi_arprot),
//    .m00_axi_arqos (m00_axi_arqos),
//    .m00_axi_aruser (m00_axi_aruser),
    .m00_axi_arvalid (m00_axi_arvalid),
    .m00_axi_arready (m00_axi_arready),
    .m00_axi_rid (m00_axi_rid),
    .m00_axi_rdata (m00_axi_rdata),
    .m00_axi_rresp (m00_axi_rresp),
    .m00_axi_rlast (m00_axi_rlast),
//    .m00_axi_ruser (m00_axi_ruser),
    .m00_axi_rvalid (m00_axi_rvalid),
    .m00_axi_rready (m00_axi_rready)
);

blk_mem_gen_0 bram (
  .s_aclk (clk_500),
  .s_aresetn (~reset),
  .s_axi_awid (m00_axi_awid),
  .s_axi_awaddr ({20'b0, m00_axi_awaddr[11:0]}),
  .s_axi_awlen (m00_axi_awlen),
  .s_axi_awsize (m00_axi_awsize),
  .s_axi_awburst (m00_axi_awburst),
//  .s_axi_awlock (m00_axi_awlock),
//  .s_axi_awcache (m00_axi_awcache),
//  .s_axi_awprot (m00_axi_awprot),
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
//  .s_axi_arlock (m00_axi_arlock),
//  .s_axi_arcache (m00_axi_arcache),
//  .s_axi_arprot (m00_axi_arprot),
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

initial         encoder_clk <= 1'b0;
always  #2      encoder_clk  <= ~encoder_clk;


// Power On reset pulse.
initial begin
  $display("INFO: Reset high.");
  reset   <= 1'b1;
  encoder_reset <= 1'b1;
  #101;
  $display("INFO: Reset low.");
  reset   <= 1'b0;
  encoder_reset <= 1'b0;
  force dut.cimg_baddr = 32'h000000000;
  force dut.simg_baddr = 32'h000000000 + 100;
  force dut.msg_baddr = 32'h00000007;
  #100;
  force dut.begin_encoding = 1'b1;
  #2;
  force dut.begin_encoding = 1'b0;
end


endmodule
