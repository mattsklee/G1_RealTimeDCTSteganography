`timescale 1 ns / 1 ns

module stream_encoder_top #(
  parameter BITS_PER_PIX = 24,

  parameter PIXELS_PER_FRAME = 1920,

  // Parameters of Axi Slave Bus Interface S00_AXIS
  // AXI4Stream sink: Data Width
  parameter C_S00_AXIS_TDATA_WIDTH = BITS_PER_PIX,  // 1 24-bit pixel

  // Parameters of Axi Master Bus Interface M00_AXIS
  // Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
  parameter integer C_M00_AXIS_TDATA_WIDTH  = BITS_PER_PIX
) (
  input clk,
  input reset,

  // Ports of Axi Slave Bus Interface S00_AXIS (read data from VDMA)
  output wire  s00_axis_tready,
  input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
  input wire  s00_axis_tlast,
  input wire [2:0] s00_axis_tkeep,
  input wire  s00_axis_tuser,
  input wire  s00_axis_tvalid,

  // Ports of Axi Master Bus Interface M00_AXIS (write data to VDMA)
  output wire  m00_axis_tvalid,
  output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
  output wire  m00_axis_tlast,
  output wire [2:0] m00_axis_tkeep,
  output wire  m00_axis_tuser,
  input wire  m00_axis_tready
);

// AXI Stream slave <-> Encoders
wire [BITS_PER_PIX-1:0] cimg_data;
wire cimg_valid;
wire [4:0] ctrl_info_in, ctrl_info_out;

// FIFOs
wire ctrl_fifo_full, simg_outfifo_full;

// Encoder <-> Output FIFO
wire [BITS_PER_PIX/8-1:0] simg_outfifo_wr_en;
wire [BITS_PER_PIX-1:0] simg_outfifo_wdata;

// Output FIFO <-> AXI Stream master
wire simg_outfifo_data_cnt;
// Has space if less than half full - room for up to 256 in-flight data.
wire simg_outfifo_has_space = (simg_outfifo_data_cnt == 1'b0);
wire [BITS_PER_PIX-1:0] simg_outfifo_rdata;
wire fifo_rd_en;
wire simg_outfifo_empty;

reg [$clog2(PIXELS_PER_FRAME+1)-1:0] pix_cntr;

// Ready to send if output FIFO has data.
assign m00_axis_tvalid = !simg_outfifo_empty;
assign m00_axis_tdata = simg_outfifo_rdata;
// Actually read data once master is ready.
assign fifo_rd_en = m00_axis_tvalid && m00_axis_tready;

// Slave ready as long as output FIFO has enough space.
assign s00_axis_tready = simg_outfifo_has_space && !(tlast_fifo_full || simg_outfifo_full); // FIFO full asserted during reset.
assign cimg_data = s00_axis_tdata;
assign cimg_valid = s00_axis_tvalid && s00_axis_tready;

// Pipe the info through, I guess.
assign ctrl_info_in[2:0] = s00_axis_tkeep;
assign ctrl_info_in[3]   = s00_axis_tlast;
assign ctrl_info_in[4]   = s00_axis_tuser;

assign m00_axis_tkeep = ctrl_info_out[2:0];
assign m00_axis_tlast = ctrl_info_out[3];
assign m00_axis_tuser = ctrl_info_out[4];

always_ff @ (posedge clk) begin
  if (reset) begin
    pix_cntr <= 1;
  end else begin
    if (fifo_rd_en) begin
      pix_cntr <= pix_cntr + 1'b1;
      if (pix_cntr == PIXELS_PER_FRAME) begin
        pix_cntr <= 1;
      end
    end
  end
end

// Generate encoders
genvar i;
generate
  for (i = 0; i < BITS_PER_PIX/8; i=i+1) begin:encoders
    stego_encode encoder (
      .clk       ( clk        ),
      .rst       ( reset      ),
      .start     ( cimg_valid ),
      .data_in   ( cimg_data[(i*8+7) -: 8] ), // 8-bit in
      .message   ( 1'b0/*msg_bits_in[i]*/        ), // 1 bit, change every 8x8 block
      .rdy       ( simg_outfifo_wr_en[i] ),  //only actually need 1 bit
      .data_out  ( simg_outfifo_wdata[(i*8+7) -: 8] )  // 8-bit out
    );
  end
endgenerate

scfifo_5in_5out_5kb ctrl_info_fifo (
  .rst        ( reset           ),
  .clk        ( clk             ),
  .din        ( ctrl_info_in    ),
  .wr_en      ( cimg_valid      ),
  .rd_en      ( fifo_rd_en      ),
  .dout       ( ctrl_info_out   ),
  .full       ( tlast_fifo_full ),
  .empty      (  )  // Unused
);

scfifo_24in_24out_12kb simg_outfifo (
  .rst        ( reset                 ),
  .clk        ( clk                   ),
  .din        ( simg_outfifo_wdata    ),
  .wr_en      ( &simg_outfifo_wr_en   ),
  .rd_en      ( fifo_rd_en            ),
  .dout       ( simg_outfifo_rdata    ),
  .full       ( simg_outfifo_full     ),
  .empty      ( simg_outfifo_empty    ),
  .data_count ( simg_outfifo_data_cnt )
);




endmodule : stream_encoder_top