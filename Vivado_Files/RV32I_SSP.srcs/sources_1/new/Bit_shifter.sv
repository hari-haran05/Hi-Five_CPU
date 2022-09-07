`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2022 14:21:32
// Design Name: 
// Module Name: Bit_shifter
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


module Bit_shifter(
    input clk,
    input en,
    input SLLI,
    input SRLI,
    input SRAI,
    input reset,
    input logic [31:0] operand_0,
    input logic [4:0] operand_1,   // LSB 5 bits of operand 1 gives the shift amount
    //input [4:0]shift_amt,
    output logic [31:0] shifted_out,
    output logic done =0
    );
    
    logic [31:0] shift_mux_0,shift_mux_1, shift_mux_2, shift_mux_3, shift_mux_4;
    logic [31:0] RA_shift_mux_0, RA_shift_mux_1, RA_shift_mux_2, RA_shift_mux_3, RA_shift_mux_4;
    logic [4:0] shift_amt;
    
    wire [31:0] ls_0,ls_1,ls_2,ls_3,ls_4,rs_0,rs_1,rs_2,rs_3,rs_4,rsa_0,rsa_1,rsa_2,rsa_3,rsa_4;
    // lsb 5 bits of operand 1 is the shift amount 
    assign shift_amt = operand_1[4:0];
    
    //left shifts 
    assign ls_0 = {operand_0[30:0],1'b0};
    assign ls_1 = {shift_mux_0[29:0],2'b00};
    assign ls_2 = {shift_mux_1[27:0],4'b0000};
    assign ls_3 = {shift_mux_2[23:0],8'h0x00};
    assign ls_4 = {shift_mux_3[15:0],16'h0x0000};
    
    //right shifts
    assign rs_0 = {1'b0,operand_0[31:1]};
    assign rs_1 = {2'b00,shift_mux_0[31:2]};
    assign rs_2 = {4'b0000,shift_mux_1[31:4]};
    assign rs_3 = {8'h0x00,shift_mux_2[31:8]};
    assign rs_4 = {16'h0x0000,shift_mux_3[31:16]};
    
    //right shifts with sign bit fill
    assign rsa_0 = {operand_0[31],operand_0[31:1]};
    assign rsa_1 = {{2{operand_0[31]}},RA_shift_mux_0[31:2]};
    assign rsa_2 = {{4{operand_0[31]}},RA_shift_mux_1[31:4]};
    assign rsa_3 = {{8{operand_0[31]}},RA_shift_mux_2[31:8]};
    assign rsa_4 = {{16{operand_0[31]}},RA_shift_mux_3[31:16]};
    
    //assign shifted_out = ((SLLI | SRLI) & ~SRAI)? shift_mux_4: RA_shift_mux_4;
    assign shifted_out = SRAI? RA_shift_mux_4:shift_mux_4 ;
    
    always_comb
    begin
        case ({SLLI,shift_amt[0]})
        2'b00, 
        2'b10: shift_mux_0 <= operand_0;
        2'b01 :shift_mux_0 <= rs_0;
        2'b11 :shift_mux_0 <= ls_0;
        endcase
    end
    
    always_comb
    begin
        case ({SLLI,shift_amt[1]})
        2'b00, 
        2'b10: shift_mux_1 <= shift_mux_0;
        2'b01 :shift_mux_1 <= rs_1;
        2'b11 :shift_mux_1 <= ls_1;
        endcase
    end
    
    always_comb
    begin
        case ({SLLI,shift_amt[2]})
        2'b00, 
        2'b10: shift_mux_2 <= shift_mux_1;
        2'b01 :shift_mux_2 <= rs_2;
        2'b11 :shift_mux_2 <= ls_2;
        endcase
    end
    
    always_comb
    begin
        case ({SLLI,shift_amt[3]})
        2'b00, 
        2'b10: shift_mux_3 <= shift_mux_2;
        2'b01 :shift_mux_3 <= rs_3;
        2'b11 :shift_mux_3 <= ls_3;
        endcase
    end
    
    always_comb
    begin
        case ({SLLI,shift_amt[4]})
        2'b00, 
        2'b10: shift_mux_4 <= shift_mux_3;
        2'b01 :shift_mux_4 <= rs_4;
        2'b11 :shift_mux_4 <= ls_4;
        endcase
    end
    
    //SRAI
    assign RA_shift_mux_0 = shift_amt[0]? rsa_0:operand_0;
    assign RA_shift_mux_1 = shift_amt[1]? rsa_1:RA_shift_mux_0;
    assign RA_shift_mux_2 = shift_amt[2]? rsa_2:RA_shift_mux_1;
    assign RA_shift_mux_3 = shift_amt[3]? rsa_3:RA_shift_mux_2;
    assign RA_shift_mux_4 = shift_amt[4]? rsa_4:RA_shift_mux_3;
    
    always_ff @(posedge clk or negedge reset)
    begin
        if (reset ==0)
            done <=0;
        else 
            
            done <= (SLLI | SRLI | SRAI) & en;
    
    
    end

endmodule
