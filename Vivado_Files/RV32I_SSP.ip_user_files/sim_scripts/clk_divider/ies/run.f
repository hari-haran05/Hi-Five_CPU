-makelib ies_lib/xil_defaultlib -sv \
  "/home/hari/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/hari/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../RV32I_SSP.srcs/sources_1/ip/clk_divider/clk_divider_clk_wiz.v" \
  "../../../../RV32I_SSP.srcs/sources_1/ip/clk_divider/clk_divider.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

