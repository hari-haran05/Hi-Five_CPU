`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2022 12:06:19
// Design Name: 
// Module Name: ALU_TB
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


module ALU_TB();


    reg clk     = 1;
    reg reset   = 1; 
    reg en      = 0;
    reg [2:0] funct3    = 0;
    reg [31:0] opcode_dec=0;
    reg funct7_5 =0,funct7_0 =0;
    reg [7:0] funct3_dec =0;
    reg [31:0] operand_0 =0;
    reg [31:0] operand_1 =0;
    wire branch_ctl;
    wire [31:0] rd_reg;
    wire rd_en;
    wire done;
    logic [31:0] sum;
    wire add_carry_out;

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
    branch_ctl,
    rd_reg,
    rd_en,
    done,
    sum,
    add_carry_out
);

//clk
always #5 clk <= ~clk;

initial 
begin
    #20;
    reset <=0;
    #20;
    reset <=1;
    #21;
   
    //ALU first operation - ADD Reg
    opcode_dec  <=  32'h0x00001000;         // 12th bit is 1
    funct3      <=  3'b000;
    funct3_dec  <=  8'h0x01;                // 1st bit is set 
    funct7_5    <=  0;
    funct7_0    <=  0;
    operand_0   <=  32'h0x00005678;
    operand_1   <=  32'h0x00004567;         // both positive numbers 
    en          <=  1'b1;
    #10;
    /***********/

    //ALU second operation - ADDI Reg
    opcode_dec  <=  32'h0x00000010;         // 12th bit is 1
    funct3      <=  3'b000;
    funct3_dec  <=  8'h0x01;                // 1st bit is set 
    funct7_5    <=  0;
    funct7_0    <=  0;
    operand_0   <=  32'h0x12345678;
    operand_1   <=  32'h0x01234567;         // both positive numbers 
    en          <=  1'b1;
    #10;
    /***********/
    
    //ALU second operation - ADDI Reg
    opcode_dec  <=  32'h0x00000010;         // 12th bit is 1
    funct3      <=  3'b000;
    funct3_dec  <=  8'h0x01;                // 1st bit is set 
    funct7_5    <=  0;
    funct7_0    <=  0;
    operand_0   <=  32'h0x12345678;
    operand_1   <=  32'h0xFFFFFFFC;         // both positive numbers 
    en          <=  1'b1;
    #10;
    /***********/
    
    //ALU FOURTH operation - sub Reg
    opcode_dec  <=  32'h0x00001000;         // 12th bit is 1
    funct3      <=  3'b000;
    funct3_dec  <=  8'h0x01;                // 1st bit is set 
    funct7_5    <=  1;
    funct7_0    <=  0;
    operand_0   <=  32'h0x12345678;
    operand_1   <=  32'h0x01234567;         // both positive numbers 
    en          <=  1'b1;
    #10;
    /***********/
    en <= 0;
    #10;
    //ALU second operation - MULT Reg
    opcode_dec  <=  32'h0x00001000;         // 12th bit is 1
    funct3      <=  3'b000;
    funct3_dec  <=  8'h0x01;                // 1st bit is set 
    funct7_5    <=  0;
    funct7_0    <=  1;
    operand_0   <=  32'h0x00345678;
    operand_1   <=  32'h0x00234567;         // both positive numbers 
    en          <=  1'b1;
    #20;
    /***********/
    
    en <= 0;
    #10;
    //ALU second operation - MULT Reg
    opcode_dec  <=  32'h0x00001000;         // 12th bit is 1
    funct3      <=  3'b000;
    funct3_dec  <=  8'h0x01;                // 1st bit is set 
    funct7_5    <=  0;
    funct7_0    <=  1;
    operand_0   <=  32'h0x00000010;
    operand_1   <=  32'h0xfffffffc;         // both positive numbers 
    en          <=  1'b1;
    #20;
    
    //ALU second operation - ADDI Reg
    opcode_dec  <=  32'h0x00000020;         // 12th bit is 1
    funct3      <=  3'b000;
    funct3_dec  <=  8'h0x01;                // 1st bit is set 
    funct7_5    <=  0;
    funct7_0    <=  0;
    operand_0   <=  32'h0x12345678;
    operand_1   <=  32'h0x01234567;         // both positive numbers 
    en          <=  1'b1;
    #10;
    /***********/
    $finish;
end


endmodule
