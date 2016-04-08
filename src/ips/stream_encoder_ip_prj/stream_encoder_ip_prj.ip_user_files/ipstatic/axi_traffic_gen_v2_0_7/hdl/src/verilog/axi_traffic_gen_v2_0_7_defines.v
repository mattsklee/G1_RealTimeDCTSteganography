//-----------------------------------------------------------------------------
// (c) Copyright 2012 - 2013 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and 
//  international copyright and other intellectual property
//  laws.
//  
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//  
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//  
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//-----------------------------------------------------------------------------
// Filename:       axi_traffic_gen_v2_0_7_defines.v
// Version : v1.0
// Description:    Defines used across different files in the design.
// Verilog-Standard:verilog-2001
//---------------------------------------------------------------------------

`define   AXIEX_REV  8'h20






// special queue with operations to extend behavior of any given cmd entry

`define SQOP_ST_IDLE      4'h0
`define SQOP_ST_ACTIVE    4'h1
`define SQOP_ST_COMPLETE  4'h2
 
`define SQOP_NOP             3'h0    // param word not examined/used
`define SQOP_REPEATOP        3'h1    // a pure repeat operation using standard cmdq delay
`define SQOP_DELAYOP         3'h2    // use full 24b for 1M+ cycle delays 
`define SQOP_FIXEDREPEATOP   3'h3    // fixed repeat count 0xffff, allows better 
                                     // parameterization of random/incr on both delay and addr

//`define PARAM_FIXEDREPEAT_COUNT 20'hffff // for fixedrepeat operation
`define PARAM_FIXEDREPEAT_COUNT 20'hff // for fixedrepeat operation


// for random address mode, need to make sure burst addrs 
//    don't increment out of range
`define SQOP_ADDRMODE_RAND_MAXBURSTBYTES_32 32'h400
`define SQOP_ADDRMODE_RAND_MAXBURSTBYTES_64 32'h800
`define SQOP_ADDRMODE_RAND_MAXBURSTBYTES_128 32'h1000
//`define SQOP_ADDRMODE_RAND_MAXBURSTBYTES_256 32'h1000
//`define SQOP_ADDRMODE_RAND_MAXBURSTBYTES_512 32'h1000




`define SQOP_ADDRMODE_CONST  2'h0
`define SQOP_ADDRMODE_INCR   2'h1
`define SQOP_ADDRMODE_RAND   2'h2


`define SQOP_INTERVALMODE_CONST 2'h0
`define SQOP_INTERVALMODE_RAND  2'h1


`define TRANX_NOACTIVITY_THRESHOLD 16'd2048
//`define TRANX_NOACTIVITY_THRESHOLD 16'd9


// register slices for timing closure 
`define REGSLICE_CMDRAM_MR_DATA 2
`define REGSLICE_CMDRAM_MR_ID        `REGSLICE_CMDRAM_MR_DATA+1
`define REGSLICE_CMDRAM_MR_REGENABLE `REGSLICE_CMDRAM_MR_DATA+4


`define REGSLICE_CMDRAM_MW_DATA 2
`define REGSLICE_CMDRAM_MW_ID        `REGSLICE_CMDRAM_MW_DATA+1
//`define REGSLICE_CMDRAM_MW_REGENABLE `REGSLICE_CMDRAM_MW_DATA+4


`define REGSLICE_PARAMRAM_DATA 1
`define REGSLICE_PARAMRAM_ID   1      


`define REGSLICE_FIFOPUSH_DATA 4







`define RAMB_INIT0 \
.INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000), \
.INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000), 





