// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sun Mar 13 09:23:33 2016
// Host        : DESKTOP-5FTSDRT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/SKL/Desktop/ECE532/project_work/integrated/test/project_2.srcs/sources_1/ip/mult_gen_0/mult_gen_0_funcsim.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0,{}" *) (* core_generation_info = "mult_gen_0,mult_gen_v12_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mult_gen,x_ipVersion=12.0,x_ipCoreRevision=7,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_OPTIMIZE_GOAL=1,C_XDEVICEFAMILY=artix7,C_HAS_CE=0,C_HAS_SCLR=0,C_LATENCY=0,C_A_WIDTH=33,C_A_TYPE=0,C_B_WIDTH=14,C_B_TYPE=0,C_OUT_HIGH=53,C_OUT_LOW=0,C_MULT_TYPE=1,C_CE_OVERRIDES_SCLR=0,C_CCM_IMP=0,C_B_VALUE=10000001,C_HAS_ZERO_DETECT=0,C_ROUND_OUTPUT=0,C_ROUND_PT=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "mult_gen_v12_0,Vivado 2015.1" *) 
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
  mult_gen_0_mult_gen_v12_0 U0
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_0_mult_gen_v12_0
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
  mult_gen_0_mult_gen_v12_0_viv i_mult
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
JErlYDKOIzZWYA2YMKQGKF5SXxFQt9RJPLxl+m36FbiGueqyX8vpocB1Tr00JofdAcML7Da9ubsi
DSmT+cCYP1Q0jOZMvwpddpLgZzN/eGm1nc3ahqheNgvltKQjhWg5Lawndk8Fz+TT5poos4n8yHL1
povvjmofQnrc5WU66qZtDbyrvgM2BccNn/RfFGZDWf/jlE5sUxqIDAMe/jEUgvPUqUlQ7ZF1HwOG
Z1eTnBbT0cL70y71mHlSVEHbP6nm72x2ZW4ldJ8wb97ZN+d/Fg0GIoacQ0Lt24xUaptMYgsL6fBX
VdxFCPmWo7E+waNOmd4hn7cUNGYynpBOivwA/w==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
HO2X0yLYrGmFQXC+bO1mCAU8QysxjuAcIXiFeXDbcNVhI9UavNoZ0rzKnFCzGXJloysEjC1XKnXo
5yNcwpR6Q4s4WSRGaHon9nwkLiFig8klHIjIqtFps57+BfzthFLpjFlAwddhxkl4BmGqZtIRJIqr
jeBcGTzlIdsmF7/G/mVluC7FofRtakuyd9sYir5/Jlw+VtNp+rx7O/iedVFbs1Oh3zCwKJnRTJxy
xkpi+8xRhkFK+BDujY+16yC09+4SpKgJjIZElYbMuy5Mzq9WKtfVNUmSm/gK99kAzCSdtBF7sVlH
fVmpVKILKkpSQCZHj8GF481hAqGR9BHExIdhQg==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 13024)
`pragma protect data_block
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
hqgjOjlM6o0br50RmJVB4WOE7RMQgh6UVZ2QBg==
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
