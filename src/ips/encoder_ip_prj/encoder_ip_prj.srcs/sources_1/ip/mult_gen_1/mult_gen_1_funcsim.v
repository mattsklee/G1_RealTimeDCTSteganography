// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sun Mar 13 09:23:31 2016
// Host        : DESKTOP-5FTSDRT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/SKL/Desktop/ECE532/project_work/integrated/test/project_2.srcs/sources_1/ip/mult_gen_1/mult_gen_1_funcsim.v
// Design      : mult_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_1,mult_gen_v12_0,{}" *) (* core_generation_info = "mult_gen_1,mult_gen_v12_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mult_gen,x_ipVersion=12.0,x_ipCoreRevision=7,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_OPTIMIZE_GOAL=1,C_XDEVICEFAMILY=artix7,C_HAS_CE=0,C_HAS_SCLR=0,C_LATENCY=0,C_A_WIDTH=12,C_A_TYPE=0,C_B_WIDTH=14,C_B_TYPE=0,C_OUT_HIGH=32,C_OUT_LOW=0,C_MULT_TYPE=1,C_CE_OVERRIDES_SCLR=0,C_CCM_IMP=0,C_B_VALUE=10000001,C_HAS_ZERO_DETECT=0,C_ROUND_OUTPUT=0,C_ROUND_PT=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "mult_gen_v12_0,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module mult_gen_1
   (A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [11:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [13:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [32:0]P;

  wire [11:0]A;
  wire [13:0]B;
  wire [32:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "12" *) 
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
  (* C_OUT_HIGH = "32" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_1_mult_gen_v12_0 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(1'b1),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "12" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "14" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "0" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "32" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_1_mult_gen_v12_0
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [11:0]A;
  input [13:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [32:0]P;
  output [47:0]PCASC;

  wire [11:0]A;
  wire [13:0]B;
  wire CE;
  wire CLK;
  wire [32:0]P;
  wire [47:0]PCASC;
  wire SCLR;
  wire [1:0]ZERO_DETECT;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "12" *) 
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
  (* C_OUT_HIGH = "32" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_1_mult_gen_v12_0_viv i_mult
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
FE74Lr97VmP2+Ez4rVovbpvB4Vynb7rIpzp8VfQztGnoDYQhPydTGw7yfEWSM5wxHTELmoJ2e0kg
nyVOAJOzGQ==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
UnafVlLwmVqAgDqs5BDZxTsO5Qw7Nz7T9DxPoDF0yCGyYUDPhiDs1mqI3Qg4QkYIJp5yYFsGIAAO
pUYs/IY/A44uoTsDTNaGtZoBJ1v68kJEgigV/osFZXpEcDoqag3/4JvCEpkiquflbTFnocW307r8
0cE640p4GyvyHA08QzM=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rfFLFKH82qRgMOK8+SSf05H2LmUnOQNDMOMMTrDokVNnoH3TrlXrFkRE/tLuqVI87gD38MoU0OsY
2vyjubJ+yK3fH69lUPsWYfAvtU2GYCn9lQxnDlilq3K9JTZOQlARVDCUJs7zKijxylKCQ9T4aeOy
qWSJQf7IY72ND0QmI4tbkWjY9UVdTMA0mNgfU1R3/x2b+5MxrvnivC5O40ApLlsTZJdrxk3CKVg9
w6j++2bBkF8pDTv4uJYJhQDDIIu6T25xOKZAldxd+F/YHif5qz+3kDBbZJwHloxlDIRuvoJ/Q10X
fAIvL1Bfmd7z81oSb2W1AQyE68hf98QRc+yt6g==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
K3+UOwlCwx3t7FyQuvXVOuOLSf79w8H29kYesB4t4ENU7w/cJ+3jINJp3g7+Mw/l3pow2eggqoBf
iR2wVOlrGRDgOMdP5om5gBbx5l7eLztB5Wu7TXxa4iclWrFOSPWLp1OuF5oKGeVz6IS+D0PiG82m
GJDW36qBP5Bj/b1u1ME=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC08_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
EXT8uDkmRcpwbfGuT5uQLCxfBwgkoXSHlzuXgPMCFUCzus9PnTSCzAm+w4+DWFCWCKofiwIYxjX+
VhvGm4jvvVmlHHmdFjkFfHf9tcT47/Qv+MNlvS1uDLyBUnKJFHfof6DVosv9docWZkjQVvvv54/h
+XjrqvpRF6uRIWJessijQgbJ5Riby6fuu5/Gao0iUQ2fUgTF8lCA3xgAXbv5+Cl5eccDmIQV/Bf+
5e2BleBP1Ac9mgOEQoT10lCrnCOifjRNdLGfLyIA4INjmFyVhYX2slSsAPtjU7fa3zGD5KNICn/M
bA66q2PSTKNLTr4xOU/9HIDRXVIaPzR1uLrkDg==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
DKwIYePtdUrZ8xl36JV+DT5gf+2OQqf9V0/VzZ1PqO/UAYDiA00fR1SB2BzQIgMSaRi4LHXMpbvC
ZAwjucWX/WAgZ4kNHNjTCDbBOtxbuewckCnVfsrILqhZQBTNh1tIxEwFUsUEvEdQTV2yrget//AZ
9vQaV1o3q24tz4J/GmuEgciVucPpFmyXVJxFVFLx3GFIiw+A5c3Y7o8HQ6y9Gb636fjJlDK+vywu
bEAduJP0zawR0j4aEY2HtYl0qvE1zDlu3hrkvBeWrlWHm+kdpKntjjZtjShGXFNfSHvet953PWzZ
+e4q1OI2IZRXiH9wD1uEt/13MusPZ/cZw9WbIA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
C62TGa04rpTkOteEzzmNVOG1S0kFYziIjPQ+l10B0J3+H8raVMwQiXLY4Z8GP549RxmIfcBuKzVK
ZBc9rY+L549SKaDrzhhUKN8bXEiTyHD/m5lJgJDwXEPvyGcx9T0F9IeYMDHxqnWQCvMfzxKqlJMk
fyD1bRFZM4jepvrjdJ8o6BPIQ9IZ6vR9PT+O5nAEq7lY0ZYyeEtPWOlvtNRYCVUGnQ8UYmSj/cEy
McUYqn3uJFVoraedHiZvpw7Ymvgr+4mB1QG8o+HeHtk+/RAuVVaVhAhQoQYeXAEy8msKt3ddLca+
AmqyvVko5QqY68Id6fk6/Ir2XXkGaRt9xo2RJA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6800)
`pragma protect data_block
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
7OAmV2rZ1trK2JUkctg6D74=
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
