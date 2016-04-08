// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Wed Mar 30 14:50:00 2016
// Host        : DESKTOP-5FTSDRT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/SKL/Desktop/ECE532/repo/streamed_encoder_ip_prj2/project_1.runs/mult_gen_1_synth_1/mult_gen_1_sim_netlist.v
// Design      : mult_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_1,mult_gen_v12_0_9,{}" *) (* core_generation_info = "mult_gen_1,mult_gen_v12_0_9,{x_ipProduct=Vivado 2015.3,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mult_gen,x_ipVersion=12.0,x_ipCoreRevision=9,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_OPTIMIZE_GOAL=1,C_XDEVICEFAMILY=artix7,C_HAS_CE=0,C_HAS_SCLR=0,C_LATENCY=0,C_A_WIDTH=12,C_A_TYPE=0,C_B_WIDTH=14,C_B_TYPE=0,C_OUT_HIGH=32,C_OUT_LOW=0,C_MULT_TYPE=1,C_CE_OVERRIDES_SCLR=0,C_CCM_IMP=0,C_B_VALUE=10000001,C_HAS_ZERO_DETECT=0,C_ROUND_OUTPUT=0,C_ROUND_PT=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "mult_gen_v12_0_9,Vivado 2015.3" *) 
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
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) 
  mult_gen_1_mult_gen_v12_0_9 U0
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_9" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_1_mult_gen_v12_0_9
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
  mult_gen_1_mult_gen_v12_0_9_viv i_mult
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
D19pIbhfL68eh2DLnT4hlU33tk/dUnzBTNXQawoWYBNCdeL7oPyQYgH1C6tlJ2BAXiV5Yki/Clmx
zv4ZjiSU//bXAxXdRW/UFzgd1Nu8/LZcJG8RtHMrF+sjiJVkwdQZxrDl2+4zwlOS6JD1t3gyLzVT
XBmDHv5rR60Qat81jA3o+MWrLbfo0hLZ6VusUiqWwzd6adLONgFjXirqby8wegFFXZ3J2vsWz6CT
C63BWCjRU6ysUnr/aRD5uhlw4YIK6ei+rao1iMAPRUG+KRfex9sqmK7vvEkQrb6IOQIapzg/IIMp
jCzOoU7Jr+8dzEDHHQk/5knO/bzCCS4ArrRRVg==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
XGCeRYMvmyTCYvxJN5TnjPwgqhYcIC+zhbK+jQUhxIZzQPVylOOV/8+EtF5CN2BosOIPAdjV5ChQ
3iH9js6nc+6SaQogrX2RFlDsqUGvCLjTBmTNBqco4l7QJQSo6BPjtK43EXIqdd9M4OaJHlAdZgJ0
RJXP95wGi0OMJEZLjAVdw+4lkEYqK8KCj4UZvEDkwGkG39GGN7U4EURIUdl6lwz7wvRxEXS7oUks
7js0JpNkXcP2RnPkQRdfWvMluO7yqqFtrRhB0olvzu/uZl4+K+8fy1aJ09wEY9TfBHG8jstVOuiR
SgCXu8jR6/9XMuUhDqwHpm6GvYw5bBEQ2uH+3g==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6848)
`pragma protect data_block
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
srIlEVh9jA0=
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
