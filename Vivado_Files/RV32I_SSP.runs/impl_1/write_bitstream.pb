
r
Command: %s
53*	vivadotcl2A
-write_bitstream -force CPU_Intergration_0.bit2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35ti2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35ti2default:defaultZ17-349h px? 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px? 
?
?Missing CFGBVS and CONFIG_VOLTAGE Design Properties: Neither the CFGBVS nor CONFIG_VOLTAGE voltage property is set in the current_design.  Configuration bank voltage select (CFGBVS) must be set to VCCO or GND, and CONFIG_VOLTAGE must be set to the correct configuration voltage, in order to determine the I/O voltage support for the pins in bank 0.  It is suggested to specify these either using the 'Edit Device Properties' function in the GUI or directly in the XDC file using the following syntax:

 set_property CFGBVS value1 [current_design]
 #where value1 is either VCCO or GND

 set_property CONFIG_VOLTAGE value2 [current_design]
 #where value2 is the voltage provided to configuration bank 0

Refer to the device configuration user guide for more information.%s*DRC2(
 DRC|Pin Planning2default:default8ZCFGBVS-1h px? 
?
YReport rule limit reached: REQP-1840 rule limit reached: 20 violations have been found.%s*DRC29
 !DRC|DRC System|Rule limit reached2default:default8ZCHECK-3h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2Z
 "D
Inst_Exe/ALU/Mult/mult	Inst_Exe/ALU/Mult/mult2default:default2default:default2d
 "N
Inst_Exe/ALU/Mult/mult/A[29:0]Inst_Exe/ALU/Mult/mult/A2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2Z
 "D
Inst_Exe/ALU/Mult/mult	Inst_Exe/ALU/Mult/mult2default:default2default:default2d
 "N
Inst_Exe/ALU/Mult/mult/B[17:0]Inst_Exe/ALU/Mult/mult/B2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__0	Inst_Exe/ALU/Mult/mult__02default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__0/A[29:0]Inst_Exe/ALU/Mult/mult__0/A2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__0	Inst_Exe/ALU/Mult/mult__02default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__0/B[17:0]Inst_Exe/ALU/Mult/mult__0/B2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__1	Inst_Exe/ALU/Mult/mult__12default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__1/A[29:0]Inst_Exe/ALU/Mult/mult__1/A2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__1	Inst_Exe/ALU/Mult/mult__12default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__1/B[17:0]Inst_Exe/ALU/Mult/mult__1/B2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
?PREG Output pipelining: DSP %s output %s is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.%s*DRC2Z
 "D
Inst_Exe/ALU/Mult/mult	Inst_Exe/ALU/Mult/mult2default:default2default:default2d
 "N
Inst_Exe/ALU/Mult/mult/P[47:0]Inst_Exe/ALU/Mult/mult/P2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPOP-1h px? 
?
?PREG Output pipelining: DSP %s output %s is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__0	Inst_Exe/ALU/Mult/mult__02default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__0/P[47:0]Inst_Exe/ALU/Mult/mult__0/P2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPOP-1h px? 
?
?PREG Output pipelining: DSP %s output %s is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__1	Inst_Exe/ALU/Mult/mult__12default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__1/P[47:0]Inst_Exe/ALU/Mult/mult__1/P2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPOP-1h px? 
?
?MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2Z
 "D
Inst_Exe/ALU/Mult/mult	Inst_Exe/ALU/Mult/mult2default:default2default:default2d
 "N
Inst_Exe/ALU/Mult/mult/P[47:0]Inst_Exe/ALU/Mult/mult/P2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPOP-2h px? 
?
?MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__0	Inst_Exe/ALU/Mult/mult__02default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__0/P[47:0]Inst_Exe/ALU/Mult/mult__0/P2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPOP-2h px? 
?
?MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2`
 "J
Inst_Exe/ALU/Mult/mult__1	Inst_Exe/ALU/Mult/mult__12default:default2default:default2j
 "T
!Inst_Exe/ALU/Mult/mult__1/P[47:0]Inst_Exe/ALU/Mult/mult__1/P2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPOP-2h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "|
2Inst_Exe/CSRU/ECU_UART/transfer_done_n_reg_i_2_n_02Inst_Exe/CSRU/ECU_UART/transfer_done_n_reg_i_2_n_02default:default2default:default2?
 "x
0Inst_Exe/CSRU/ECU_UART/transfer_done_n_reg_i_2/O0Inst_Exe/CSRU/ECU_UART/transfer_done_n_reg_i_2/O2default:default2default:default2?
 "t
.Inst_Exe/CSRU/ECU_UART/transfer_done_n_reg_i_2	.Inst_Exe/CSRU/ECU_UART/transfer_done_n_reg_i_22default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[0]	ID/operand_0_reg[0]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2V
 "@
ID/operand_0_reg[10]	ID/operand_0_reg[10]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2V
 "@
ID/operand_0_reg[11]	ID/operand_0_reg[11]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[2]	ID/operand_0_reg[2]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[3]	ID/operand_0_reg[3]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[4]	ID/operand_0_reg[4]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[5]	ID/operand_0_reg[5]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[6]	ID/operand_0_reg[6]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[7]	ID/operand_0_reg[7]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[8]	ID/operand_0_reg[8]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_0_reg[9]	ID/operand_0_reg[9]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_1_reg[0]	ID/operand_1_reg[0]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2V
 "@
ID/operand_1_reg[10]	ID/operand_1_reg[10]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2V
 "@
ID/operand_1_reg[11]	ID/operand_1_reg[11]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_1_reg[1]	ID/operand_1_reg[1]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_1_reg[2]	ID/operand_1_reg[2]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_1_reg[3]	ID/operand_1_reg[3]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_1_reg[4]	ID/operand_1_reg[4]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_1_reg[5]	ID/operand_1_reg[5]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
?
?RAMB18 async control check: The RAMB18E1 %s has an input control pin %s (net: %s) which is driven by a register (%s) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.%s*DRC2n
 "X
 Data_Mem_Unit/data_mem_array_reg	 Data_Mem_Unit/data_mem_array_reg2default:default2default:default2?
 "x
0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]0Data_Mem_Unit/data_mem_array_reg/ADDRARDADDR[12]2default:default2default:default2f
 "P
Data_Mem_Unit/ADDRARDADDR[7]Data_Mem_Unit/ADDRARDADDR[7]2default:default2default:default2T
 ">
ID/operand_1_reg[6]	ID/operand_1_reg[6]2default:default2default:default2B
 *DRC|Netlist|Instance|Required Pin|RAMB18E12default:default8Z	REQP-1840h px? 
g
DRC finished with %s
1905*	planAhead2)
0 Errors, 35 Warnings2default:defaultZ12-3199h px? 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px? 
i
)Running write_bitstream with %s threads.
1750*designutils2
82default:defaultZ20-2272h px? 
?
Loading data files...
1271*designutilsZ12-1165h px? 
>
Loading site data...
1273*designutilsZ12-1167h px? 
?
Loading route data...
1272*designutilsZ12-1166h px? 
?
Processing options...
1362*designutilsZ12-1514h px? 
<
Creating bitmap...
1249*designutilsZ12-1141h px? 
7
Creating bitstream...
7*	bitstreamZ40-7h px? 
i
Writing bitstream %s...
11*	bitstream2,
./CPU_Intergration_0.bit2default:defaultZ40-11h px? 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px? 
?
?WebTalk data collection is mandatory when using a WebPACK part without a full Vivado license. To see the specific WebTalk data collected for your design, open the usage_statistics_webtalk.html or usage_statistics_webtalk.xml file in the implementation directory.
120*projectZ1-120h px? 
?
?'%s' has been successfully sent to Xilinx on %s. For additional details about this file, please refer to the Webtalk help file at %s.
186*common2?
y/home/hari/Documents/Projects/RISC-V/Verilog_implementations/RV32I_SSP/RV32I_SSP.runs/impl_1/usage_statistics_webtalk.xml2default:default2,
Fri Sep  2 23:00:17 20222default:default2W
C/home/hari/tools/Xilinx/Vivado/2019.1/doc/webtalk_introduction.html2default:defaultZ17-186h px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1132default:default2
562default:default2
02default:default2
02default:defaultZ4-41h px? 
a
%s completed successfully
29*	vivadotcl2#
write_bitstream2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2%
write_bitstream: 2default:default2
00:00:132default:default2
00:00:212default:default2
2971.7232default:default2
177.1602default:default2
3922default:default2
84592default:defaultZ17-722h px? 


End Record