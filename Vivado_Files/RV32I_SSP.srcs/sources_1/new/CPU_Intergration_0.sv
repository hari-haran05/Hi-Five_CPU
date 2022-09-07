`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2022 21:59:07
// Design Name: 
// Module Name: CPU_Intergration_0
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_Intergration_0(
    input hard_reset,
    input clk,   //clk_in
    input uart_rx,
    output uart_tx,
    //output misalign_exp,
    output [2:0] done,
    output CPU_halt
    );
    
    parameter WORD_LN = 32;
    parameter ADDR_LN = 8;
    
    wire reset;
    wire [2:0] enable;
    wire [31:0]pc;
    wire [31:0]rs1;
    wire [31:0]rs2;
    wire [31:0] rs2_reg;
    wire [31:0]opcode_dec;
    wire [7:0]funct3_dec;
    wire  funct7_5;
    wire funct7_0;
    wire [31:0]operand_0;
    wire [31:0]operand_1;
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [4:0] rd_addr;
    wire rs1_ren;
    wire rs2_ren;
    wire control_unit_enable;
    //wire [2:0] done;
    
    wire [31:0] IF_rd_data;
    wire [31:0] ALU_rd_data;
    wire [31:0] CSR_rd_data;
    wire [31:0] LSU_rd_data;
    wire ALU_rd_en;
    wire LSU_rd_en;
    wire CSR_rd_en;
    wire IF_rd_en;
    
    wire branch_ctl;
    wire inst_mem_rd_valid;
    wire inst_mem_rd_en;
    wire [WORD_LN-1:0]instr_rdata;
    wire [4:0] opcode;
    wire [2:0] funct3;
    wire [WORD_LN-1:0] Dmem_rd_data;
    wire [ADDR_LN-1:0] Dmem_rd_addr;
    wire Dmem_rd_en;
    wire Dmem_store_valid;
    wire [ADDR_LN-1:0] Dmem_wr_addr;
    wire [WORD_LN-1:0] Dmem_wr_data;
    wire Dmem_wr_en;
    wire Dmem_master_sel;
    //wire CPU_halt;   
    wire [WORD_LN-1:0] instr_wr_data;
    wire [ADDR_LN-1:0] instr_wr_addr;
    wire instr_wr_en,instr_wr_ack;
    
    wire [WORD_LN-1:0] ctr_Dmem_wr_data;
    wire [ADDR_LN-1:0] ctr_Dmem_wr_addr;
    wire ctr_Dmem_wr_en;
    wire ctr_Dmem_rd_en;
    wire [WORD_LN-1:0] ctr_Dmem_rd_data;
    wire [ADDR_LN-1:0] ctr_Dmem_rd_addr;
    wire Jump_done;
    wire [31:0] imm_val;
    wire misalign_exp;
    wire clk;
    
    assign opcode = instr_rdata[6:2];        //opcode from the instruction
    assign funct3 = instr_rdata[14:12];      // funct3 
    
    // clock divider clk_in - 100M, clk - 5M
    /*clk_divider instance_name
   (
    // Clock out ports
    .clk_out(clk),     // output clk_out
    // Status and control signals
    .resetn(1'b1), // input resetn
   // Clock in ports
    .clk_in(clk_in));      // input clk_in
// INST_TAG_END ------ End INSTANTIATION Template ---------
        */
    
    Inst_Fetch_Unit IFU (
    clk,
    imm_val,
    operand_0,
    branch_ctl,
    opcode_dec[27],
    opcode_dec[25],
    reset,
    enable[0],      // pc_en - pc should be updated in the execute stage only.
    enable[2],
    inst_mem_rd_valid,
    IF_rd_data,
    pc,
    misalign_exp,
    inst_mem_rd_en,
    done[2],
    IF_rd_en,
    Jump_done 
    );
    
    Inst_Decoder ID (
        instr_rdata,
        clk,
        reset,
        enable[1],
        pc,
        rs1,
        rs2,
        opcode_dec,
        funct3_dec,
        funct7_5,
        funct7_0,
        operand_0,
        operand_1,
        imm_val,
        rs1_addr,
        rs2_addr,
        rd_addr,
        rs1_ren,
        rs2_ren,
        done[1],
        rs2_reg
        );
    
    Register_Set Reg_file (
        clk,
        reset,
        enable[1],
        rs1_addr,
        rs2_addr,
        rd_addr,
        IF_rd_en,
        ALU_rd_en,
        CSR_rd_en,
        LSU_rd_en,
        opcode,
        IF_rd_data,
        ALU_rd_data,
        CSR_rd_data,
        LSU_rd_data,
        rs1,
        rs2
    );
    
    Instruction_Execute Inst_Exe (
        clk,
        reset ,
        enable[0],
        funct3,
        opcode,
        opcode_dec,
        funct7_5,
        funct7_0,
        funct3_dec,
        operand_0,
        operand_1,
        Dmem_rd_data,
        ctr_Dmem_rd_data,
        rs2_reg,
        Dmem_store_valid,
        uart_rx,
        Jump_done,
        Dmem_rd_addr,
        ctr_Dmem_rd_addr,
        Dmem_rd_en,
        ctr_Dmem_rd_en,
        Dmem_wr_addr,
        Dmem_wr_data,
        Dmem_wr_en,
        Dmem_master_sel,
        branch_ctl,
        ALU_rd_data,
        LSU_rd_data,
        CSR_rd_data,
        ALU_rd_en,
        LSU_rd_en,
        CSR_rd_en,
        uart_tx,
        CPU_halt,
        done[0]
    );
    
    Control_Unit_Moore Control (
        clk,
        reset,
        CPU_halt,
        1'b1,                //control_unit_enable,
        done,
        enable
    );
    
    Inst_Memory inst_mem (
    clk,
    instr_wr_data,
    instr_wr_addr,
    instr_wr_en,
    inst_mem_rd_en,
    instr_rdata,
    pc[9:0],
    1'b1,
    1'b0,       //no writes to instr mem
    inst_mem_rd_valid,
    instr_wr_ack
    );
    
    data_Memory Data_Mem_Unit (
        clk,
        reset,
        ctr_Dmem_wr_data,
        ctr_Dmem_wr_addr,
        ctr_Dmem_wr_en,
        Dmem_wr_data,
        Dmem_wr_addr,
        Dmem_wr_en,
        Dmem_rd_en,
        Dmem_rd_data,
        Dmem_rd_addr,
        ctr_Dmem_rd_en,
        ctr_Dmem_rd_data,
        ctr_Dmem_rd_addr,
        Dmem_master_sel,
        Dmem_store_valid 
    );
    
    Reset_synchronizer reset_sync (
    hard_reset,
    clk,
    reset,
    control_unit_enable
    );
endmodule
