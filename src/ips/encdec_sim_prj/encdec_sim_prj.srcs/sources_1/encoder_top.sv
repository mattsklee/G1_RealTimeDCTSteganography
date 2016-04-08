`timescale 1 ns / 1 ns

module encoder_top #(
  parameter ADDR_WIDTH = 32,
  parameter DATA_WIDTH = 32,
  parameter BITS_PER_PIX = 32,
  parameter NUM_COLS = 1280,
  parameter NUM_ROWS = 720,

  // Parameters of Axi Slave Bus Interface S00_AXI
  parameter integer C_S00_AXI_DATA_WIDTH = 32,
  parameter integer C_S00_AXI_ADDR_WIDTH = 5,

  // Parameters of Axi Master Bus Interface M00_AXI
  parameter integer C_M00_AXI_BURST_LEN   = 128,
  parameter integer C_M00_AXI_ID_WIDTH    = 1,
  parameter integer C_M00_AXI_ADDR_WIDTH  = 32,
  parameter integer C_M00_AXI_DATA_WIDTH  = 32,
  parameter integer C_M00_AXI_AWUSER_WIDTH    = 0,
  parameter integer C_M00_AXI_ARUSER_WIDTH    = 0,
  parameter integer C_M00_AXI_WUSER_WIDTH = 0,
  parameter integer C_M00_AXI_RUSER_WIDTH = 0,
  parameter integer C_M00_AXI_BUSER_WIDTH = 0
) (
  input axi_clk,
  input axi_resetn,
  input encoder_clk,
  input encoder_reset,

  // Ports of Axi Slave Bus Interface S00_AXI
  input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
  input wire [2 : 0] s00_axi_awprot,
  input wire  s00_axi_awvalid,
  output wire  s00_axi_awready,
  input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
  input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
  input wire  s00_axi_wvalid,
  output wire  s00_axi_wready,
  output wire [1 : 0] s00_axi_bresp,
  output wire  s00_axi_bvalid,
  input wire  s00_axi_bready,
  input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
  input wire [2 : 0] s00_axi_arprot,
  input wire  s00_axi_arvalid,
  output wire  s00_axi_arready,
  output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
  output wire [1 : 0] s00_axi_rresp,
  output wire  s00_axi_rvalid,
  input wire  s00_axi_rready,


  // Ports of Axi Master Bus Interface M00_AXI
  output wire  m00_axi_error,
  output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid,
  output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr,
  output wire [7 : 0] m00_axi_awlen,
  output wire [2 : 0] m00_axi_awsize,
  output wire [1 : 0] m00_axi_awburst,
  output wire  m00_axi_awlock,
  output wire [3 : 0] m00_axi_awcache,
  output wire [2 : 0] m00_axi_awprot,
  output wire [3 : 0] m00_axi_awqos,
  output wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser,
  output wire  m00_axi_awvalid,
  input wire  m00_axi_awready,
  output wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata,
  output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
  output wire  m00_axi_wlast,
  output wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser,
  output wire  m00_axi_wvalid,
  input wire  m00_axi_wready,
  input wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid,
  input wire [1 : 0] m00_axi_bresp,
  input wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser,
  input wire  m00_axi_bvalid,
  output wire  m00_axi_bready,
  output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid,
  output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr,
  output wire [7 : 0] m00_axi_arlen,
  output wire [2 : 0] m00_axi_arsize,
  output wire [1 : 0] m00_axi_arburst,
  output wire  m00_axi_arlock,
  output wire [3 : 0] m00_axi_arcache,
  output wire [2 : 0] m00_axi_arprot,
  output wire [3 : 0] m00_axi_arqos,
  output wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser,
  output wire  m00_axi_arvalid,
  input wire  m00_axi_arready,
  input wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid,
  input wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
  input wire [1 : 0] m00_axi_rresp,
  input wire  m00_axi_rlast,
  input wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser,
  input wire  m00_axi_rvalid,
  output wire  m00_axi_rready
);

localparam IMG_RBURST_LEN = C_M00_AXI_BURST_LEN;
localparam IMG_WBURST_LEN = IMG_RBURST_LEN;
localparam NUM_WREQS_PER_SIMG = NUM_ROWS*NUM_COLS*BITS_PER_PIX/(IMG_WBURST_LEN*DATA_WIDTH);
localparam NUM_RREQS_PER_CIMG = NUM_ROWS*NUM_COLS*BITS_PER_PIX/(IMG_RBURST_LEN*DATA_WIDTH);
// FIXME: this changes with changes in how many bits of msg are encoded per 8*8 byte block.
localparam NUM_CIMG_RREQS_PER_MSG_RREQ = 512;


// AXI slave <-> FSMs
wire [ADDR_WIDTH-1:0] cimg_baddr;
wire [ADDR_WIDTH-1:0] simg_baddr;
wire [ADDR_WIDTH-1:0] msg_baddr;
wire begin_encoding;
wire done_encoding;

// DRAM RREQ FSM <-> inFIFO
wire msg_infifo_has_space;
wire cimg_infifo_has_space;
wire msg_infifo_wr_data_cnt;
wire [1:0] cimg_infifo_wr_data_cnt;
assign msg_infifo_has_space = (msg_infifo_wr_data_cnt == 1'b0);
assign cimg_infifo_has_space = (cimg_infifo_wr_data_cnt == 2'b0);

// DRAM RRSP FSM to inFIFOs
wire msg_infifo_wr_en;
wire cimg_infifo_wr_en;
wire finished_receiving_frame;

// cimg inFIFO to encoder
wire cimg_infifo_empty;
reg cimg_infifo_empty_d1;
wire [31:0] cimg_infifo_rdata;
reg sync_start_sig;

// msg inFIFO to encoder
wire msg_infifo_empty;
reg msg_infifo_empty_d1;
wire msg_infifo_rd_en;
wire [31:0] msg_infifo_rdata;
wire [3:0] msg_bits_in;

// Encoder to outFIFO
wire simg_outfifo_wr_en;
wire [31:0] simg_outfifo_wdata;

// outFIFO <-> DRAM WREQ FSM
wire simg_outfifo_has_enough_data;
wire simg_outfifo_rd_en, simg_outfifo_first_rd_en;
wire [31:0] simg_outfifo_rdata;
wire [1:0] simg_outfifo_rd_data_cnt;
assign simg_outfifo_has_enough_data = (simg_outfifo_rd_data_cnt >= 2'b1);
assign simg_outfifo_rd_en = (wnext || simg_outfifo_first_rd_en) && ~(m00_axi_wlast);

// AXI master <-> FSMs
wire [ADDR_WIDTH-1:0] dram_raddr;
wire dram_rreq;
wire [ADDR_WIDTH-1:0] dram_waddr;
wire dram_wreq;
wire wnext;
wire [DATA_WIDTH-1:0] outgoing_data;
assign outgoing_data = simg_outfifo_rdata;

wire axi_m_rburst_active;
wire axi_m_wburst_active;
wire [DATA_WIDTH-1:0] incoming_data;
wire incoming_data_valid;

reg axi_m_can_accept_rreq, axi_m_can_accept_wreq;
always_comb begin
  // Can accept when read burst is not active and we haven't already
  // requested a read last cycle (rburst_active takes 1 cycle to update)
  axi_m_can_accept_rreq = !(axi_m_rburst_active || dram_rreq);
  // Same thing for write burst
  axi_m_can_accept_wreq = !(axi_m_wburst_active || dram_wreq);
end


encoder_axi_s_v1_0 #(
  .C_S00_AXI_DATA_WIDTH (C_S00_AXI_DATA_WIDTH),
  .C_S00_AXI_ADDR_WIDTH (C_S00_AXI_ADDR_WIDTH)
) encoder_axi_s (
  .cover_img_addr ( cimg_baddr     ), // output
  .stego_img_addr ( simg_baddr     ), // output
  .msg_addr       ( msg_baddr      ), // output
  .begin_encoding ( begin_encoding ), // output
  .done_encoding  ( done_encoding  ), // input

  .s00_axi_aclk (axi_clk),
  .s00_axi_aresetn (axi_resetn),
  .s00_axi_awaddr (s00_axi_awaddr),
  .s00_axi_awprot (s00_axi_awprot),
  .s00_axi_awvalid (s00_axi_awvalid),
  .s00_axi_awready (s00_axi_awready),
  .s00_axi_wdata (s00_axi_wdata),
  .s00_axi_wstrb (s00_axi_wstrb),
  .s00_axi_wvalid (s00_axi_wvalid),
  .s00_axi_wready (s00_axi_wready),
  .s00_axi_bresp (s00_axi_bresp),
  .s00_axi_bvalid (s00_axi_bvalid),
  .s00_axi_bready (s00_axi_bready),
  .s00_axi_araddr (s00_axi_araddr),
  .s00_axi_arprot (s00_axi_arprot),
  .s00_axi_arvalid (s00_axi_arvalid),
  .s00_axi_arready (s00_axi_arready),
  .s00_axi_rdata (s00_axi_rdata),
  .s00_axi_rresp (s00_axi_rresp),
  .s00_axi_rvalid (s00_axi_rvalid),
  .s00_axi_rready (s00_axi_rready)
);

encoder_dram_rreq_fsm #(
  .ADDR_WIDTH ( ADDR_WIDTH ),
  .DATA_WIDTH ( DATA_WIDTH ),
  .IMG_RBURST_LEN ( IMG_RBURST_LEN ),
  .NUM_RREQS_PER_CIMG ( NUM_RREQS_PER_CIMG ),
  .NUM_CIMG_RREQS_PER_MSG_RREQ ( NUM_CIMG_RREQS_PER_MSG_RREQ )
) rreq_fsm (
  // Inputs
  .axi_clk ( axi_clk ),
  .axi_resetn ( axi_resetn ),
  .msg_baddr ( msg_baddr ),
  .cimg_baddr ( cimg_baddr ),
  .begin_encoding ( begin_encoding ),
  .axi_m_can_accept_rreq ( axi_m_can_accept_rreq ),
  .msg_infifo_has_space ( msg_infifo_has_space ),
  .cimg_infifo_has_space ( cimg_infifo_has_space ),

  // Outputs
  .dram_raddr ( dram_raddr ),
  .dram_rreq ( dram_rreq )
);

encoder_dram_rrsp_fsm #(
  .IMG_RBURST_LEN ( IMG_RBURST_LEN ),
  .NUM_RREQS_PER_CIMG ( NUM_RREQS_PER_CIMG ),
  .NUM_CIMG_RREQS_PER_MSG_RREQ ( NUM_CIMG_RREQS_PER_MSG_RREQ )
) rrsp_fsm (
  // Inputs
  .axi_clk ( axi_clk ),
  .axi_resetn ( axi_resetn ),
  .begin_encoding ( begin_encoding ),
  .incoming_data_valid ( incoming_data_valid ),

  // Unregistered outputs; available same cycle as matching incoming_data_valid
  .msg_infifo_wr_en ( msg_infifo_wr_en ),
  .cimg_infifo_wr_en ( cimg_infifo_wr_en ),
  .finished_receiving_frame ( finished_receiving_frame)
);

dcfifo_32in_32out_8kb msg_infifo (
  .rst           ( !axi_resetn            ), // ASYNCHRONOUS reset; use axi clk
  .wr_clk        ( axi_clk                ),
  .rd_clk        ( encoder_clk            ),
  .din           ( incoming_data          ),
  .wr_en         ( msg_infifo_wr_en       ),
  .rd_en         ( msg_infifo_rd_en       ),
  .dout          ( msg_infifo_rdata       ),
  .full          (  ),  // Unused
  .empty         ( msg_infifo_empty       ),
  .wr_data_count ( msg_infifo_wr_data_cnt )
);

dcfifo_32in_32out_16kb_wr_cnt cimg_infifo (
  .rst           ( !axi_resetn             ), // ASYNCHRONOUS reset; use axi clk
  .wr_clk        ( axi_clk                 ),
  .rd_clk        ( encoder_clk             ),
  .din           ( incoming_data           ),
  .wr_en         ( cimg_infifo_wr_en       ),
  .rd_en         ( !cimg_infifo_empty      ),
  .dout          ( cimg_infifo_rdata       ),
  .full          (  ),  // Unused
  .empty         ( cimg_infifo_empty       ),
  .wr_data_count ( cimg_infifo_wr_data_cnt )
);


always_ff @ (posedge encoder_clk) begin
  if (encoder_reset) begin
    msg_infifo_empty_d1 <= 1'b1;
    cimg_infifo_empty_d1 <= 1'b1;
  end else begin
    msg_infifo_empty_d1 <= msg_infifo_empty;
    cimg_infifo_empty_d1 <= cimg_infifo_empty;
  end
end


encoder_msg_fsm #(
) msg_fsm (
  .encoder_clk        ( encoder_clk          ),
  .encoder_reset      ( encoder_reset        ),
  .next_msg_word      ( msg_infifo_rdata     ),
  .msg_infifo_empty   ( msg_infifo_empty_d1  ),
  .cimg_infifo_empty  ( cimg_infifo_empty_d1 ),

  .get_next_msg_word  ( msg_infifo_rd_en     ),
  .current_msg_nibble ( msg_bits_in           )
);

// Channel 0
stego_encode encoder0 (
  .clk      ( encoder_clk           ),
  .rst      ( encoder_reset         ),
  .start    ( !cimg_infifo_empty_d1 ),
  .data_in  ( cimg_infifo_rdata[7:0]     ), // 8-bit in
  .message  ( msg_bits_in[0]            ), // 1 bit, change every 8x8 block
  .rdy      ( simg_outfifo_wr_en    ),
  .data_out ( simg_outfifo_wdata[7:0]    )  // 8-bit out
);

// Channel 1
stego_encode encoder1 (
  .clk      ( encoder_clk           ),
  .rst      ( encoder_reset         ),
  .start    ( !cimg_infifo_empty_d1 ),
  .data_in  ( cimg_infifo_rdata[15:8]     ), // 8-bit in
  .message  ( msg_bits_in[1]            ), // 1 bit, change every 8x8 block
  .rdy      (     ),
  .data_out ( simg_outfifo_wdata[15:8]    )  // 8-bit out
);

// Channel 2
stego_encode encoder2 (
  .clk      ( encoder_clk           ),
  .rst      ( encoder_reset         ),
  .start    ( !cimg_infifo_empty_d1 ),
  .data_in  ( cimg_infifo_rdata[23:16]     ), // 8-bit in
  .message  ( msg_bits_in[2]            ), // 1 bit, change every 8x8 block
  .rdy      (     ),
  .data_out ( simg_outfifo_wdata[23:16]    )  // 8-bit out
);

// Channel 3
stego_encode encoder3 (
  .clk      ( encoder_clk           ),
  .rst      ( encoder_reset         ),
  .start    ( !cimg_infifo_empty_d1 ),
  .data_in  ( cimg_infifo_rdata[31:24]     ), // 8-bit in
  .message  ( msg_bits_in[3]            ), // 1 bit, change every 8x8 block
  .rdy      (     ),
  .data_out ( simg_outfifo_wdata[31:24]    )  // 8-bit out
);

dcfifo_32in_32out_16kb_rd_cnt simg_outfifo (
  .rst           ( !axi_resetn              ), // ASYNCHRONOUS reset; use axi clk
  .wr_clk        ( encoder_clk              ),
  .rd_clk        ( axi_clk                  ),
  .din           ( simg_outfifo_wdata       ),
  .wr_en         ( simg_outfifo_wr_en       ),
  .rd_en         ( simg_outfifo_rd_en       ),
  .dout          ( simg_outfifo_rdata       ),
  .full          (  ),  // Unused
  .empty         (  ),
  .rd_data_count ( simg_outfifo_rd_data_cnt )
);


encoder_dram_wreq_fsm #(
  .ADDR_WIDTH ( ADDR_WIDTH ),
  .DATA_WIDTH ( DATA_WIDTH ),
  .IMG_WBURST_LEN ( IMG_WBURST_LEN ),
  .NUM_WREQS_PER_SIMG ( NUM_WREQS_PER_SIMG )  
) wreq_fsm (
  // Inputs
  .axi_clk    ( axi_clk ),
  .axi_resetn ( axi_resetn ),
  .simg_baddr ( simg_baddr ),
  .begin_encoding ( begin_encoding ),
  .axi_m_can_accept_wreq ( axi_m_can_accept_wreq ),
  .wnext                 ( wnext ),  
  .simg_outfifo_has_enough_data ( simg_outfifo_has_enough_data ),

  // Outputs
  .simg_outfifo_first_rd_en ( simg_outfifo_first_rd_en ),
  .dram_waddr         ( dram_waddr ),
  .dram_wreq          ( dram_wreq ),
  .done_encoding      ( done_encoding )
);


encoder_axi_m_v1_0 #(
  .C_M00_AXI_BURST_LEN(IMG_RBURST_LEN),
  .C_M00_AXI_ID_WIDTH(C_M00_AXI_ID_WIDTH),
  .C_M00_AXI_ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH),
  .C_M00_AXI_DATA_WIDTH(C_M00_AXI_DATA_WIDTH),
  .C_M00_AXI_AWUSER_WIDTH(C_M00_AXI_AWUSER_WIDTH),
  .C_M00_AXI_ARUSER_WIDTH(C_M00_AXI_ARUSER_WIDTH),
  .C_M00_AXI_WUSER_WIDTH(C_M00_AXI_WUSER_WIDTH),
  .C_M00_AXI_RUSER_WIDTH(C_M00_AXI_RUSER_WIDTH),
  .C_M00_AXI_BUSER_WIDTH(C_M00_AXI_BUSER_WIDTH)
) encoder_axi_m (
  .incoming_data        ( incoming_data       ),  // output
  .incoming_data_valid  ( incoming_data_valid ),  // output
  .rburst_active        ( axi_m_rburst_active ),  // output
  .wburst_active        ( axi_m_wburst_active ),  // output
  .wnext                ( wnext               ),  // output
  .dram_rreq            ( dram_rreq           ),  // input
  .dram_wreq            ( dram_wreq           ),  // input
  .dram_raddr           ( dram_raddr          ),  // input
  .dram_waddr           ( dram_waddr          ),  // input
  .outgoing_data        ( outgoing_data       ),  // input

  .m00_axi_error (m00_axi_error),
  .m00_axi_aclk (axi_clk),
  .m00_axi_aresetn (axi_resetn),
  .m00_axi_awid (m00_axi_awid),
  .m00_axi_awaddr (m00_axi_awaddr),
  .m00_axi_awlen (m00_axi_awlen),
  .m00_axi_awsize (m00_axi_awsize),
  .m00_axi_awburst (m00_axi_awburst),
  .m00_axi_awlock (m00_axi_awlock),
  .m00_axi_awcache (m00_axi_awcache),
  .m00_axi_awprot (m00_axi_awprot),
  .m00_axi_awqos (m00_axi_awqos),
  .m00_axi_awuser (m00_axi_awuser),
  .m00_axi_awvalid (m00_axi_awvalid),
  .m00_axi_awready (m00_axi_awready),
  .m00_axi_wdata (m00_axi_wdata),
  .m00_axi_wstrb (m00_axi_wstrb),
  .m00_axi_wlast (m00_axi_wlast),
  .m00_axi_wuser (m00_axi_wuser),
  .m00_axi_wvalid (m00_axi_wvalid),
  .m00_axi_wready (m00_axi_wready),
  .m00_axi_bid (m00_axi_bid),
  .m00_axi_bresp (m00_axi_bresp),
  .m00_axi_buser (m00_axi_buser),
  .m00_axi_bvalid (m00_axi_bvalid),
  .m00_axi_bready (m00_axi_bready),
  .m00_axi_arid (m00_axi_arid),
  .m00_axi_araddr (m00_axi_araddr),
  .m00_axi_arlen (m00_axi_arlen),
  .m00_axi_arsize (m00_axi_arsize),
  .m00_axi_arburst (m00_axi_arburst),
  .m00_axi_arlock (m00_axi_arlock),
  .m00_axi_arcache (m00_axi_arcache),
  .m00_axi_arprot (m00_axi_arprot),
  .m00_axi_arqos (m00_axi_arqos),
  .m00_axi_aruser (m00_axi_aruser),
  .m00_axi_arvalid (m00_axi_arvalid),
  .m00_axi_arready (m00_axi_arready),
  .m00_axi_rid (m00_axi_rid),
  .m00_axi_rdata (m00_axi_rdata),
  .m00_axi_rresp (m00_axi_rresp),
  .m00_axi_rlast (m00_axi_rlast),
  .m00_axi_ruser (m00_axi_ruser),
  .m00_axi_rvalid (m00_axi_rvalid),
  .m00_axi_rready (m00_axi_rready)
);

endmodule : encoder_top