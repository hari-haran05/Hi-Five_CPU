`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2022 15:47:25
// Design Name: 
// Module Name: Inst_Fetch_Unit
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


module Inst_Fetch_Unit(
    input clk,
    input [31:0] imm_val,
    input [31:0] rs1,
    input op_BRANCH,
    input op_JAL,
    input op_JALR,
    input reset,
    input pc_en,
    input cpu_inst_rd_en,
    input inst_rd_valid,
    output logic [31:0] rd_out,
    output logic [31:0] pc,
    output logic misalign_exp,
    output logic inst_rd_en,
    output logic cpu_inst_rd_valid,
    output logic IF_rd_en =0,
    output logic Jump_done =0 
    );
    
    
    logic [31:0] next_pc;
    logic [31:0] operand_1;
    logic [31:0] target_addr ;  
    logic IF_rd_en_buf  =0;
    assign JAL_Or_B = op_BRANCH | op_JAL;
    assign J_Or_B   = JAL_Or_B | op_JALR;
    assign add_pc   = JAL_Or_B & (~op_JALR);
   
   
    logic [31:0]pc_plus_4;
    assign pc_plus_4 = pc + 32'h0x00000004; //pc + 32'h0x00000004; inst mem is of 32 bits wide, it expects word-address 
    
    //assign rd_out = pc_plus_4;
    
    assign operand_1 = add_pc ? pc : rs1;
    assign target_addr = operand_1 + imm_val;
    assign next_pc = J_Or_B ? target_addr : pc_plus_4;
    PC pc_reg (.clk(clk), .next_pc(next_pc), .reset(reset), .en(pc_en), .pc(pc));
    
    assign cpu_inst_rd_valid = inst_rd_valid;
    assign inst_rd_en = cpu_inst_rd_en;
    assign misalign_exp = pc[0] | pc[1] ; // last two lsb should always be 00, -> 4 byte boundary , if not raise misaigned address exception 
    
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset ==0)
            rd_out <= 0;
        else
        begin
            if (op_JAL | op_JALR )
            begin
                rd_out <= pc_plus_4;
            end
        end
    
    
    end
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset ==0)
        begin
            IF_rd_en    <= 0;
            IF_rd_en_buf<= 0;
            Jump_done   <= 0;

        end
        else
            IF_rd_en<= (op_JAL | op_JALR )& pc_en;
            Jump_done   <=  IF_rd_en;               
    end
    
    //done signal for jump instr
  
    
endmodule
