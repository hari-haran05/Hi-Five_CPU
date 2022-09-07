-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
-- Date        : Fri Sep  2 22:46:16 2022
-- Host        : professor running 64-bit Ubuntu 18.04.4 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/hari/Documents/Projects/RISC-V/Verilog_implementations/RV32I_SSP/RV32I_SSP.srcs/sources_1/ip/clk_divider/clk_divider_stub.vhdl
-- Design      : clk_divider
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_divider is
  Port ( 
    clk_out : out STD_LOGIC;
    resetn : in STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end clk_divider;

architecture stub of clk_divider is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,resetn,clk_in";
begin
end;
