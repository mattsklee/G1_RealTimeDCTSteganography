// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Wed Mar 30 14:50:02 2016
// Host        : DESKTOP-5FTSDRT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/SKL/Desktop/ECE532/repo/streamed_encoder_ip_prj2/project_1.runs/mult_gen_0_synth_1/mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_9,{}" *) (* core_generation_info = "mult_gen_0,mult_gen_v12_0_9,{x_ipProduct=Vivado 2015.3,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mult_gen,x_ipVersion=12.0,x_ipCoreRevision=9,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_OPTIMIZE_GOAL=1,C_XDEVICEFAMILY=artix7,C_HAS_CE=0,C_HAS_SCLR=0,C_LATENCY=0,C_A_WIDTH=33,C_A_TYPE=0,C_B_WIDTH=14,C_B_TYPE=0,C_OUT_HIGH=53,C_OUT_LOW=0,C_MULT_TYPE=1,C_CE_OVERRIDES_SCLR=0,C_CCM_IMP=0,C_B_VALUE=10000001,C_HAS_ZERO_DETECT=0,C_ROUND_OUTPUT=0,C_ROUND_PT=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "mult_gen_v12_0_9,Vivado 2015.3" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [32:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [13:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [53:0]P;

  wire [32:0]A;
  wire [13:0]B;
  wire [53:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "33" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "14" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "53" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) 
  mult_gen_0_mult_gen_v12_0_9 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(1'b1),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "33" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "14" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "0" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "53" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_9" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_0_mult_gen_v12_0_9
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [32:0]A;
  input [13:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [53:0]P;
  output [47:0]PCASC;

  wire [32:0]A;
  wire [13:0]B;
  wire CE;
  wire CLK;
  wire [53:0]P;
  wire [47:0]PCASC;
  wire SCLR;
  wire [1:0]ZERO_DETECT;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "33" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "14" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "53" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_0_mult_gen_v12_0_9_viv i_mult
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(SCLR),
        .ZERO_DETECT(ZERO_DETECT));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
DndfBI7K3jXgN7GHRcECwyAER1W1Qh1PMsFelxk+HDT/ClV9Zo8izeECQIpMvK29OdY6SSkvB4qZ
+AYx/myMTw==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
CdiSOlcZSDfE8CurfVdELYArX3+TnREZq8E2Yz6CqivQQWiw5RGxv4Gl7Au5kxChzGyLzNLvpmhT
ppQfKBpf+XrJYAfKx28pTmAx8X2waXhIlI0DeX8Ov4RDfCu2fd87Q/1t9q5AVlYHTpz7Pm37oQMC
BonWIfylGOa+liG14eQ=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
gt7F+PGAaFvQvayxMkye/PdntejydD0eqxluJporKL/eE7tO3gqhoJWrHr6EJ2JeFopjz8ez1QhZ
7fAYU5KG/SEWjH1mXWJASfakqz5iOx3/i4t+1xPIK6IS2CWsRDWrz7qcp4f25fwEKkNTRTb0kA3S
z037QRb6Gcl9T23pQbGxiebbA2gHBh4zigT1WwGjqx80nEVyADg7jOuLU2FeqX8nsBo4aya1AaGy
GqejeJaJ5IQ7EY9/zBAWE+DzyhN4Gv8mYP8lGSxa3Sth13PiRU0xsOZGac9yKFHDFVMpCjhoYAJR
tGl0wUk3TSBcSnsYqPGgP97x9w0OHGuDh5JvkA==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
iuUGkiCJWqD6S+Ivv2+2YU4CYQvzOyv4L6Khf5yoSOlP+8rsrITJxR/snSS95M2cb2SYmzGxjaxu
2TAok7Q+ox5BAM9XQweWOfuwovlgJjHrloEcnxbtYORZwicYwSa91IutF7z8AhDo36QmuOnZx1Z9
NZoQDVYrfJs8Kz0Yenw=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC15_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
a8x2Lj9mmpL4v+zPKabbpGXEXECaXjvwa8IWoZyGK6gZzcKlusapcFQp2jYobjGuXoqhkYYp4ANR
/7TGF2cuIszd4V+i1ZZL4M5UXTQh9kLT8emsG5cwnR+Nehucye0a/SdOcbn6Pcg7yMce/+zpuuV0
ex4jlZMAsXf6i1il2ddPdtWT3k2AbR+Am3/f8ushp2fsmcGMgRVNtOOYROsCDX4KlRdas9YXlkq5
9d+ubkYzakIVQa0PQ0jQJQPW2/C1fKNsLisKy4kJNaDNwiXo2Ve5N6Qxb5irFP8wZ6iapscbnarw
DNy84LnVZiSVsU3OP8/S7YHAsdW5lukpeuJb8g==


`pragma protect key_keyowner = "ATRENTA", key_keyname= "ATR-SG-2015-RSA-3", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
oHWnYLE0J5rZZEnXMuTAQxu9NgUolVXZM5hq9TvCFq0x5b12/jzoW51moxTIzUBj2smQ/sB1QlS7
m2fDrJuFXKoj/HCk0KONHoXlaXmLeXQqL6HYfKw/j2F2fFIBmmAhAJ5qyyPkPnlXCvkE7fsc67s3
qz8a+KKsHGqGWBdeF3lAT6y/10HKSeR6oGugaujjA2CDnjVv5Me6lAzz5C8lRfbolqR+3RNm4o5P
Ra7RJtGQz1ANkLxMLrxpjcw7kXNTLrC08BCVAukRWzPhr9a9wfHitoK0WlXx9s/o5jOgg3Z6WSqF
sJxU74LBWwstEEO17Re4mT3AJPySE6IUwgXMTw==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
TOeHEz07yLnXq1KJBe3T4/U/GnqIun+5rH/HHNrCFBzR8f6vv0/3ibUm4Q0u751Vz4zgT6mY9dpn
NRGcINFXmsrtx+Tw5cZMOIzm0+3+94aNVP/8Fs85Clits5pjzkEuEHGc3vAhYSh/6aZQhaCFj43V
UZgb6AgSy0Lx4Zg11FlApDSVfmru26YP/x2a7eLY5Yl1NzdHWZSC01PvpL3vV0hm6h91JJ+o85At
o4r32wVSfsSPD8b7LebjMB4Houv7LNpbCH9IReal4xeGEzFCrsKo40unNHiHU4OLfq+sJlg6qoT1
ou4EYtcmM1NFg2YzSpY6LxHBR3Gy3cnklzLJwA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
lHB6n0R84hctVnXs2Km//0K1NUHPAIrlwuUmYJy+Jsop8FwVal49m7Ex+ziXjq4Be8snrMLu+JRE
Fv2GjMv1s9upl3mTUk0zGPXB/gRN9NdODiX/rC/xPv9TPva7ZqNZfn/oorLKZ1qrqfoOSAfGsknc
OXWmbjZBWVj5c2xpQxbWfeEIOK5wRxsaPnAQWbloWJKSL9+Zt+DI8fBTnVeKzLpuGCg5EQGoPzMA
Xdf6j6idXmrlTU/2jEH5ppPn/Kx6X8YcUEOJVDa2uQfqCuR3PuDnLwb72xDZk7Xcxfjgo3+Zy258
XHjstfxj89mgeTuAvCu/VuX6jA5Q7viSICrsmw==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11280)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
