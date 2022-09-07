`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2022 14:23:36
// Design Name: 
// Module Name: Arithmetic_logic_Unit
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
/* 
    This module makes up the Arithmetic Logical Unit of the CPU. this also includes the Multiplier unit 
*/

module Arithmetic_logic_Unit(
    input clk,
    input reset ,
    input en,
    input [2:0] funct3,
    input [31:0] opcode_dec,
    input funct7_5,
    input funct7_0,
    input [7:0] funct3_dec,
    input [31:0] operand_0,
    input [31:0] operand_1,
    output logic branch_done =0,
    output branch_ctl,
    output logic [31:0] rd_reg = 0,
    output logic rd_en = 0,
    output logic done =0,
    output [31:0] sum,
    output add_carry_out
    
    
    );
    
    wire sub;
    //wire add_carry_out;
    //wire [31:0] sum;
    wire [31:0]Int_ALU_out[0:7];
    wire Int_ALU_done[7:0];
    wire [31:0]Int_ALU_out_mux;
    logic Int_ALU_done_mux;
    wire [31:0] AUIPC_out;
    wire AUIPC_done;
    wire [31:0] Mul_Div_out ;
    wire Mul_Div_done;
    logic [31:0] Mul_Div_out_mux;
    logic Mul_Div_done_mux;
    logic [31:0] rd;
    wire done_buf;
    
    assign sub = funct7_5 & opcode_dec[12]; // SUB only when opcode = OP and funct7.5 = 1
    assign AUIPC_out = Int_ALU_out[0];      // AUIPC is an add instruction realised with the same Adder as for interger addition
    assign AUIPC_done = Int_ALU_done[0];
    assign Int_ALU_out[5] = Int_ALU_out[1];     // Right and Left shift are done in the same bit shifter block. Hence the output is shared by both.
    assign Int_ALU_done[5] = Int_ALU_done[1];
    assign done_buf           = rd_en;                        // the done signal indicated that the calculation is done and a valid rd output is available 
    assign Int_ALU_done[3] = Int_ALU_done[2];   // all the logical operations share the same done signal
    assign Int_ALU_done[4] = Int_ALU_done[2];
    assign Int_ALU_done[6] = Int_ALU_done[2];
    assign Int_ALU_done[7] = Int_ALU_done[2];
    
    assign sum = Int_ALU_out[0];                //sum output, could be used by LSU to calculate dest mem address
    //assign Int_ALU_out[0] = sum;
    
    Adder Add (
        clk,
        en,                   // always enabled. the ALU_out mux will select this output only when the funct3 value matches that of an ADD instr
        reset,
        operand_0,
        operand_1,
        1'b0,
        ~sub,                   // 1- ADD , 0- SUB
        add_carry_out,
        Int_ALU_out[0],
        Int_ALU_done[0]
    );
    
    Multiplier Mult (
        clk,
        en,               // always enabled, the ALU_out mux will select this only when its instr is issued
        reset,
        operand_0,
        operand_1,
        Mul_Div_out,
        Mul_Div_done
    );
    
    Bit_shifter bit_shift (
    clk,
    en,
    funct3_dec[1],
    funct3_dec[5],
    funct3_dec[5] & funct7_5,
    reset,
    operand_0,
    operand_1[4:0],   
    Int_ALU_out[1],
    Int_ALU_done[1]
    );
    
    Logical_Operators logical_operantor(
    clk,
    reset,
    opcode_dec[24],                 //0x11000 is the opcode for Branch instr
    operand_0,
    operand_1,
    funct3,
    en,                           // enabled always, the ALU out mux selects the correct operation acc to the given instr
    branch_ctl,
    Int_ALU_out[6],                 //funct3 of 6 indicates OR
    Int_ALU_out[4],                 //          4           XOR
    Int_ALU_out[7],                 //          7           AND 
    Int_ALU_out[3],                 //          3           SLT(I)U
    Int_ALU_out[2],                 //          2           SLT(I)
    Int_ALU_done[2] 
    
    );
    
    // Int ALU out mux -> selects the correct operation acc to the funct3 bits 
    assign Int_ALU_out_mux = Int_ALU_out[funct3];
    //assign Int_ALU_done_mux =Int_ALU_done[funct3];
    
    always_comb
    begin
        Int_ALU_done_mux <= Int_ALU_done[funct3];
    end
    
    
    // Mul_Div out mux : since only the MUL instr is implemented, only if funct3 is 000, a multiplication output is produced, for all other values, the output is 0
    always_comb
    begin
        case (funct3)
            3'b000: 
            begin
                Mul_Div_out_mux <= Mul_Div_out;
                Mul_Div_done_mux <= Mul_Div_done;
            end
            default:
            begin
                Mul_Div_out_mux <= 32'h0x00000000;
                Mul_Div_done_mux <= 1'b0;
            end
        endcase
    end
    
    // Rd output value is selected from 3 different operations according to the current instr- Mul, Int_ALU, AUIPC
    // If opcode_dec[5] - AUIPC  
    //    funt7_0 - Mult operation 
    always_comb
    begin
        case({opcode_dec[5],funct7_0})
            2'b00:
            begin
                rd <= Int_ALU_out_mux;
                rd_en <= Int_ALU_done_mux;
            end
            2'b01:
            begin
                rd <= Mul_Div_out_mux;
                rd_en <= Mul_Div_done_mux;
            end
            2'b10,
            2'b11:
            begin
                rd <= AUIPC_out;
                rd_en <= AUIPC_done; 
            end
        endcase
    end
    
    
    // register the rd output 
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset == 0 )
            rd_reg <= 0;
        else
            if (en)
                rd_reg <= rd;
            
    end 
    
    // delay the done signal by 1 clk 
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset == 0 )
        begin
            done <= 0;
            branch_done <= 0;
        end
        else
        begin
            //if (en)
            //begin
                done <= done_buf;
            //end
             branch_done <= opcode_dec[24] & en;
        end        
    end 
    
endmodule
