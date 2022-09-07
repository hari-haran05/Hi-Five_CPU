// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Fri Sep  2 22:46:16 2022
// Host        : professor running 64-bit Ubuntu 18.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/hari/Documents/Projects/RISC-V/Verilog_implementations/RV32I_SSP/RV32I_SSP.srcs/sources_1/ip/clk_divider/clk_divider_stub.v
// Design      : clk_divider
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_divider(clk_out, resetn, clk_in)
/* synthesis syn_black_box black_box_pad_pin="clk_out,resetn,clk_in" */;
  output clk_out;
  input resetn;
  input clk_in;
endmodule
