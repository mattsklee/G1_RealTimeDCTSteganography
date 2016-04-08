`timescale 1 ns / 1 ns

module decoder_top #(
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
  input decoder_clk,
  input decoder_reset,

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
localparam MSG_WBURST_LEN = IMG_RBURST_LEN;
localparam NUM_RREQS_PER_SIMG = NUM_ROWS*NUM_COLS*BITS_PER_PIX/(IMG_RBURST_LEN*DATA_WIDTH);

// Round down to the closest integer.
localparam NUM_WREQS_PER_SIMG = ((NUM_ROWS*NUM_COLS*BITS_PER_PIX/(512*DATA_WIDTH))/MSG_WBURST_LEN) * MSG_WBURST_LEN;


// AXI slave <-> FSMs
wire [ADDR_WIDTH-1:0] simg_baddr;
wire [ADDR_WIDTH-1:0] msg_baddr;
wire begin_decoding;
wire done_decoding;

// DRAM RREQ FSM <-> inFIFO
wire simg_infifo_has_space;
wire [1:0] simg_infifo_wr_data_cnt;
assign simg_infifo_has_space = (simg_infifo_wr_data_cnt == 2'b0);

// DRAM RRSP FSM to inFIFO
wire simg_infifo_wr_en;
wire finished_receiving_frame;

// simg inFIFO to decoder
wire simg_infifo_empty;
reg simg_infifo_empty_d1;
wire [31:0] simg_infifo_rdata;


// Decoder to outFIFO (via msg accumulator (into 32-bit words))
wire [3:0] msg_bits_out;
wire msg_valid;
reg [2:0] msg_valid_cnt;
reg [31:0] msg_word_shift;
reg msg_outfifo_wr_en;

// outFIFO <-> DRAM WREQ FSM
wire msg_outfifo_has_enough_data;
wire msg_outfifo_rd_en, msg_outfifo_first_rd_en;
wire [31:0] msg_outfifo_rdata;
wire msg_outfifo_rd_data_cnt;
assign msg_outfifo_has_enough_data = (msg_outfifo_rd_data_cnt == 1'b1);
assign msg_outfifo_rd_en = (wnext || msg_outfifo_first_rd_en) && ~(m00_axi_wlast);


// AXI master <-> FSMs
wire [ADDR_WIDTH-1:0] dram_raddr;
wire dram_rreq;
wire [ADDR_WIDTH-1:0] dram_waddr;
wire dram_wreq;
wire wnext;
wire [DATA_WIDTH-1:0] outgoing_data;
assign outgoing_data = msg_outfifo_rdata;

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


decoder_axi_s_v1_0 #(
  .C_S00_AXI_DATA_WIDTH (C_S00_AXI_DATA_WIDTH),
  .C_S00_AXI_ADDR_WIDTH (C_S00_AXI_ADDR_WIDTH)
) decoder_axi_s (
  .stego_img_addr ( simg_baddr     ), // output
  .msg_addr       ( msg_baddr      ), // output
  .begin_decoding ( begin_decoding ), // output
  .done_decoding  ( done_decoding  ), // input

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

decoder_dram_rreq_fsm #(
  .ADDR_WIDTH ( ADDR_WIDTH ),
  .DATA_WIDTH ( DATA_WIDTH ),
  .IMG_RBURST_LEN ( IMG_RBURST_LEN ),
  .NUM_RREQS_PER_SIMG ( NUM_RREQS_PER_SIMG )
) rreq_fsm (
  // Inputs
  .axi_clk ( axi_clk ),
  .axi_resetn ( axi_resetn ),
  .msg_baddr ( msg_baddr ),
  .simg_baddr ( simg_baddr ),
  .begin_decoding ( begin_decoding ),
  .axi_m_can_accept_rreq ( axi_m_can_accept_rreq ),
  .simg_infifo_has_space ( simg_infifo_has_space ),

  // Outputs
  .dram_raddr ( dram_raddr ),
  .dram_rreq ( dram_rreq )
);

decoder_dram_rrsp_fsm #(
  .IMG_RBURST_LEN ( IMG_RBURST_LEN ),
  .NUM_RREQS_PER_SIMG ( NUM_RREQS_PER_SIMG )
) rrsp_fsm (
  // Inputs
  .axi_clk ( axi_clk ),
  .axi_resetn ( axi_resetn ),
  .begin_decoding ( begin_decoding ),
  .incoming_data_valid ( incoming_data_valid ),

  // Unregistered outputs; available same cycle as matching incoming_data_valid
  .finished_receiving_frame ( finished_receiving_frame)
);

dcfifo_32in_32out_16kb simg_infifo (
  .rst           ( !axi_resetn             ), // ASYNCHRONOUS reset; use axi clk
  .wr_clk        ( axi_clk                 ),
  .rd_clk        ( decoder_clk             ),
  .din           ( incoming_data           ),
  .wr_en         ( incoming_data_valid     ), // Always simg data incoming!
  .rd_en         ( !simg_infifo_empty      ),
  .dout          ( simg_infifo_rdata       ),
  .full          (  ),  // Unused
  .empty         ( simg_infifo_empty       ),
  .wr_data_count ( simg_infifo_wr_data_cnt )
);


always_ff @ (posedge decoder_clk) begin
  if (decoder_reset) begin
    simg_infifo_empty_d1 <= 1'b1;
  end else begin
    simg_infifo_empty_d1 <= simg_infifo_empty;
  end
end


stego_decode decoder0 (
  .clk      ( decoder_clk           ),
  .rst      ( decoder_reset         ),
  .start    ( !simg_infifo_empty_d1 ),
  .data_in  ( simg_infifo_rdata[7:0] ), // 8-bit in
  .message  ( msg_bits_out[0]         ), // 1 bit out
  .rdy      ( msg_valid             )
);

stego_decode decoder1 (
  .clk      ( decoder_clk           ),
  .rst      ( decoder_reset         ),
  .start    ( !simg_infifo_empty_d1 ),
  .data_in  ( simg_infifo_rdata[15:8] ), // 8-bit in
  .message  ( msg_bits_out[1]          ), // 1 bit out
  .rdy      (              )
);

stego_decode decoder2 (
  .clk      ( decoder_clk           ),
  .rst      ( decoder_reset         ),
  .start    ( !simg_infifo_empty_d1 ),
  .data_in  ( simg_infifo_rdata[23:16] ), // 8-bit in
  .message  ( msg_bits_out[2]           ), // 1 bit out
  .rdy      (              )
);

stego_decode decoder3 (
  .clk      ( decoder_clk           ),
  .rst      ( decoder_reset         ),
  .start    ( !simg_infifo_empty_d1 ),
  .data_in  ( simg_infifo_rdata[31:24]  ), // 8-bit in
  .message  ( msg_bits_out[3]            ), // 1 bit out
  .rdy      (              )
);


// Gather msg output bits into 32-bit words.
always_ff @(posedge decoder_clk) begin
  if (decoder_reset) begin
    msg_outfifo_wr_en <= 1'b0;
    msg_word_shift <= 0;
    msg_valid_cnt <= 0;
  end else begin
    // Default values
    msg_outfifo_wr_en <= 1'b0;
    msg_word_shift <= msg_word_shift;
    msg_valid_cnt <= msg_valid_cnt;

    if (msg_valid) begin
      // LSBs come out first.
      msg_word_shift <= {msg_bits_out[3:0], msg_word_shift[31:4]};
      msg_valid_cnt <= msg_valid_cnt + 1'b1;
      if (msg_valid_cnt == 3'd7) begin
        msg_outfifo_wr_en <= 1'b1;
      end
    end
  end
end

dcfifo_32in_32out_8kb_cnt msg_outfifo (
  .rst           ( !axi_resetn              ), // ASYNCHRONOUS reset; use axi clk
  .wr_clk        ( decoder_clk              ),
  .rd_clk        ( axi_clk                  ),
  .din           ( msg_word_shift           ),
  .wr_en         ( msg_outfifo_wr_en        ),
  .rd_en         ( msg_outfifo_rd_en        ),
  .dout          ( msg_outfifo_rdata        ),
  .full          (  ),  // Unused
  .empty         (  ),
  .rd_data_count ( msg_outfifo_rd_data_cnt  )
);


decoder_dram_wreq_fsm #(
  .ADDR_WIDTH ( ADDR_WIDTH ),
  .DATA_WIDTH ( DATA_WIDTH ),
  .MSG_WBURST_LEN ( MSG_WBURST_LEN ),
  .NUM_WREQS_PER_SIMG ( NUM_WREQS_PER_SIMG )  
) wreq_fsm (
  // Inputs
  .axi_clk    ( axi_clk ),
  .axi_resetn ( axi_resetn ),
  .msg_baddr  ( msg_baddr ),
  .begin_decoding ( begin_decoding ),
  .axi_m_can_accept_wreq ( axi_m_can_accept_wreq ),
  .wnext                 ( wnext ),  
  .msg_outfifo_has_enough_data ( msg_outfifo_has_enough_data ),

  // Outputs
  .msg_outfifo_first_rd_en ( msg_outfifo_first_rd_en ),
  .dram_waddr         ( dram_waddr ),
  .dram_wreq          ( dram_wreq ),
  .done_decoding      ( done_decoding )
);


// The write to DRAM is same as the encoder one.
decoder_axi_m_v1_0 #(
  .C_M00_AXI_BURST_LEN(IMG_RBURST_LEN),
  .C_M00_AXI_ID_WIDTH(C_M00_AXI_ID_WIDTH),
  .C_M00_AXI_ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH),
  .C_M00_AXI_DATA_WIDTH(C_M00_AXI_DATA_WIDTH),
  .C_M00_AXI_AWUSER_WIDTH(C_M00_AXI_AWUSER_WIDTH),
  .C_M00_AXI_ARUSER_WIDTH(C_M00_AXI_ARUSER_WIDTH),
  .C_M00_AXI_WUSER_WIDTH(C_M00_AXI_WUSER_WIDTH),
  .C_M00_AXI_RUSER_WIDTH(C_M00_AXI_RUSER_WIDTH),
  .C_M00_AXI_BUSER_WIDTH(C_M00_AXI_BUSER_WIDTH)
) decoder_axi_m (
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

endmodule : decoder_top