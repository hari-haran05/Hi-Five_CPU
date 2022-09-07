`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2022 07:40:25
// Design Name: 
// Module Name: Logical_Operators
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


module Logical_Operators(
    input clk,
    input reset,
    input branch_en,
    input logic [31:0] operand_0,
    input logic [31:0] operand_1,
    input [2:0]funct3,
    input logic_en,
    output logic branch_valid,
    output logic [31:0] OR_out,
    output logic [31:0] XOR_out,
    output logic [31:0] AND_out, 
    output logic [31:0] compare_out_u,
    output logic [31:0] compare_out,
    output logic done =0 
    );
    
    logic equal;
    logic less_than_u;
    logic branch;
    
    assign XOR_out = operand_0 ^ operand_1;
    assign AND_out = operand_0 & operand_1;
    assign OR_out  = operand_0 | operand_1;
    
    assign equal = (operand_0 == operand_1);
    assign less_than_u = (operand_0 < operand_1);
    
    assign branch_valid = branch_en & branch;
    
    always_comb
    begin
        case (funct3)
        3'b000: branch = equal;
        3'b001: branch = ~equal;
        3'b110: branch = less_than_u;
        3'b111: branch =  ~(less_than_u) | equal;    //(~less_than_u & ~equal;
        default:branch = 1'b0;
        endcase
    end
    
    assign compare_out_u = less_than_u? 32'h0x00000001:32'h0x00000000;
    
    always_comb
    begin
        case ({operand_0[31],operand_1[31]})
            2'b00,
            2'b11:  compare_out <= compare_out_u;
            2'b01:  compare_out <= 32'h0x00000000;
            2'b10:  compare_out <= 32'h0x00000001;
        endcase
    end
    
    always_ff @(posedge clk or negedge reset)
    begin
        if (reset ==0)
            done <=0;
        else 
            done <= logic_en;
    
    
    end
endmodule
