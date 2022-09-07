`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2022 16:45:31
// Design Name: 
// Module Name: Instr_Fetch_TB
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


module Instr_Fetch_TB(
/*output logic [31:0] instr_data,
input logic cpu_mem_en,
input ctr_mem_en,
input logic reset,
input logic en,
input cpu_inst_rd_en,
output cpu_inst_rd_valid
*/
);


logic clk =1;
always #5 clk = ~clk; 

logic [31:0] imm_val = 32'h0x00000014;
logic [31:0] rs1     = 32'h0x00000002;
logic [2:0] opcode   = 3'b000;
logic reset =1;
logic pc_en=0;
logic cpu_inst_rd_en =0;
logic inst_rd_valid;
logic [31:0] rd_out;
logic [31:0] pc = 0;
logic misalign_exp;
logic inst_rd_en;
logic cpu_inst_rd_valid;

logic [31:0] ctr_wr_data =0;
logic [7 :0] ctr_wr_addr = 0;
logic ctr_wr_en =0 ;
logic [31:0] instr_data;
logic cpu_mem_en = 0 ;
logic ctr_mem_en =0 ;
logic cpu_rd_valid;
logic ctr_wr_ack;

Inst_Fetch_Unit IF(clk,imm_val, rs1,opcode[0],opcode[1],opcode[2],reset,pc_en,cpu_inst_rd_en,inst_rd_valid,rd_out,pc,misalign_exp,inst_rd_en,cpu_inst_rd_valid );

Inst_Memory inst_mem (clk,
    ctr_wr_data,
    ctr_wr_addr,
    ctr_wr_en,
    inst_rd_en,
    instr_data,
    pc[9:2],    //leaving the last two lsb to generate word aligned address
    cpu_mem_en,
    ctr_mem_en,
    inst_rd_valid,
    ctr_wr_ack
    );



initial
begin
    #20;
    reset <= 0; 
    #10;
    #10;
    reset <=1;
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    
    #10
    pc_en <=0;
    
    #10;
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    
    #10
    pc_en <=0;
    //inst cycle 3
    #10;
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    opcode <= 3'b001; // branch inst
    
    #10
    //$stop;
    pc_en <=0;
    opcode <= 3'b000;
    #10;
    
    //instruction cycle 4
    
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    opcode <=  3'b010; // JAL instr
    #10
    pc_en <=0;
    opcode <= 3'b000;
    //$stop;
    #10;
    
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    opcode <= 3'b100;
    #10
    pc_en <=0;
    opcode <= 3'b000;
    #10;
    
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    opcode <= 3'b001;
    imm_val <= 32'h0xFFFFFFFC;   // -4 -> 1100 , sign extended to 32 bits
    #10
    pc_en <=0;
    opcode <= 3'b000;
    #10;
    
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    opcode <= 3'b010;
    #10
    pc_en <=0;
    opcode <= 3'b000;
    #10;
    
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    opcode <= 3'b010;
    rs1 <= 32'h0x0000002C;
    imm_val <= 32'h0x00000015;
    #10
    pc_en <=0;
    opcode <= 3'b000;
    #10;
    
    // Instruction fetch cycle: enabling the inst_mem to read the instr
    cpu_mem_en <= 1;
    cpu_inst_rd_en <=1;
    #10;
    // check if the inst_rd was valid, if not stall the fetch cycle
    wait ( cpu_inst_rd_valid);
    
    cpu_mem_en <=0;
    cpu_inst_rd_en <=0;

    #10;
    // Enalbe pc calculation in the Execute stage
    pc_en <= 1;
    
    #10
    pc_en <=0;
    
    #10;
    $finish;
end

endmodule
