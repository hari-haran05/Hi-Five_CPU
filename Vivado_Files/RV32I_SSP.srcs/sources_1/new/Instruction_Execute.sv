`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2022 17:16:20
// Design Name: 
// Module Name: Instruction_Execute
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


module Instruction_Execute #(
parameter ADDR_LN = 8, parameter WORD_LN =32)                            
(
    input clk,
    input reset ,
    input en,
    input [2:0] funct3,
    input [4:0] opcode,
    input [31:0] opcode_dec,
    input funct7_5,
    input funct7_0,
    input [7:0] funct3_dec,
    input [31:0] operand_0,
    input [31:0] operand_1,
    input [31:0] LSU_mem_rd_data,
    input [31:0] CSR_mem_rd_data,
    input [WORD_LN-1:0] rs2_data,
    input mem_store_valid,
    input uart_rx,
    input Jump_done,
    output [ADDR_LN-1:0] LSU_mem_rd_addr,
    output [ADDR_LN-1:0] CSR_mem_rd_addr,
    output LSU_mem_rd_en,
    output CSR_mem_rd_en,
    output [ADDR_LN-1:0] mem_wr_addr,
    output [WORD_LN-1:0] mem_wr_data,
    output mem_wr_en,
    output mem_master_sel,
    output branch_ctl,
    output [31:0] ALU_rd,
    output [31:0] LSU_rd,
    output [31:0] CSR_rd,
    output ALU_rd_en,
    output LSU_rd_en,
    output CSR_rd_en,
    output uart_tx,
    output CPU_halt,
    output reg done
    
    );
    
    parameter JAL = 5'b11011;
    parameter JALR = 5'b11001;
    parameter LUI = 5'b01101;
    parameter AUIPC = 5'b00101;
    parameter LOAD  = 5'b00000;
    parameter OP_IMM = 5'b00100;
    parameter OP = 5'b01100;
    parameter CSU = 5'b11100;
    parameter STORE =5'b01000;
    parameter BRANCH = 5'b11000;
    
    wire [31:0] sum;
    /*wire [WORD_LN-1:0] LSU_mem_rd_data;
    wire [WORD_LN-1:0] CSR_mem_rd_data;
    wire [ADDR_LN-1:0] LSU_mem_rd_addr;
    wire [ADDR_LN-1:0] CSR_mem_rd_addr;
    wire LSU_mem_rd_en;
    wire CSR_mem_rd_en;
    */
    wire add_carry_out; // dummy, not used
    wire LSU_done,ALU_done,CSR_done; 
    wire CSR_en;
    wire csr_cpu_halt;
    wire branch_done;
    
    assign CSR_en = opcode_dec[28] & en;      // enable CSR only when its opcode is given
    assign CPU_halt = csr_cpu_halt;
    
    //Data memory interface is shared by both CSR and LSU 
    /*assign mem_rd_addr  = opcode_dec[28] ? CSR_mem_rd_addr: LSU_mem_rd_addr;
    assign mem_rd_en    = opcode_dec[28] ? CSR_mem_rd_en : LSU_mem_rd_en;
    assign CSR_mem_rd_data  = opcode_dec[28] ? mem_rd_data : 32'h0x00000000;
    assign LSU_mem_rd_data  = opcode_dec[28] ? 32'h0x00000000: mem_rd_data;
    */
    Load_Store_Unit LSU (
        clk,
        en,
        reset,
        sum,
        funct3,
        opcode_dec,
        operand_1,
        LSU_mem_rd_data,
        rs2_data,
        mem_store_valid,
        LSU_mem_rd_addr,
        mem_wr_addr,
        mem_wr_data,
        LSU_mem_rd_en,
        mem_wr_en,
        LSU_rd,
        //mem_en,
        LSU_rd_en, 
        LSU_done 
    
    );
    
    Arithmetic_logic_Unit ALU (
        clk,
        reset ,
        en,
        funct3,
        opcode_dec,
        funct7_5,
        funct7_0,
        funct3_dec,
        operand_0,
        operand_1,
        branch_done,
        branch_ctl,
        ALU_rd,
        ALU_rd_en,
        ALU_done,
        sum,
        add_carry_out
    );
    
    Control_Status_Register_Unit CSRU (
        clk,
        reset ,
        CSR_en,
        funct3_dec,
        operand_0,
        operand_1,
        CSR_mem_rd_data,
        uart_rx,
        uart_tx,
        CSR_rd,
        CSR_rd_en,
        CSR_mem_rd_addr,
        CSR_mem_rd_en,
        mem_master_sel,
        csr_cpu_halt,
        CSR_done
    );
    
    always_comb
    begin
        case(opcode)
            LOAD,LUI,STORE: 
        begin
            done <= LSU_done;
        end
        AUIPC,OP_IMM,OP:
        begin
            done  <= ALU_done;
        end
        CSU:
        begin
            done <= CSR_done;
        end
        JAL,JALR:
        begin
            done <= Jump_done;
        end
        BRANCH:
        begin
            done <= branch_done;
        end
        default : done <= 0;
        endcase
    end
endmodule
