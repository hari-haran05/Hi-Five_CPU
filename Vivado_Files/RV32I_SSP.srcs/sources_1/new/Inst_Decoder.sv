`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2022 01:55:40
// Design Name: 
// Module Name: Inst_Decoder
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


module Inst_Decoder(
    input [31:0] instr,
    input clk,
    input reset,
    input en,
    input [31:0]pc,
    input [31:0]rs1,
    input [31:0]rs2,
    output logic [31:0]opcode_dec_ff,
    output logic [7:0] funct3_dec_ff,
    //output logic [127:0] funct7_dec_ff,
    output logic funct7_5,
    output logic funct7_0,
    output logic [31:0]operand_0,
    output logic [31:0]operand_1,
    output logic [31:0] imm_val =0,
    output logic [4:0] rs1_addr,
    output logic [4:0] rs2_addr,
    output logic[4:0] rd_addr,
    output rs1_ren,
    output rs2_ren,
    output logic Instr_Decode_done =0,
    output logic [31:0]rs2_out
    );
    
    parameter JAL   = 5'b11011;
    parameter JALR  = 5'b11001;
    parameter LUI   = 5'b01101;
    parameter AUIPC = 5'b00101;
    parameter LOAD  = 5'b00000;
    parameter OP_IMM = 5'b00100;
    parameter OP    = 5'b01100;
    //parameter MULT  = 5'b01100;
    parameter FENCE = 5'b00011;
    parameter SYSTEM= 5'b11100;
    parameter STORE = 5'b01000;
    parameter BRANCH= 5'b11000;
    //various immediate encodings
    logic [31:0] i_imm;
    logic [31:0] s_imm;
    logic [31:0] b_imm;
    logic [31:0] u_imm;
    logic [31:0] j_imm;
    logic [31:0] imm_mux;
    
    
    //unregistered decoder outputs
    logic [31:0]opcode_dec;
    logic [7:0] funct3_dec;
    logic [127:0] funct7_dec;
        
    //funct7_5 and funct7_0 are just the respective bits of the instr
    assign funct7_5 = instr[30];
    assign funct7_0 = instr[25];
    
    //instruction type decoding
    logic instr_r,instr_i,instr_s,instr_b,instr_u,instr_j;
    assign i_imm = { {20{instr[31]}},instr[31:20]};
    assign s_imm = { {20{instr[31]}},instr[31:25],instr[11:7]};
    assign b_imm = { {19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0 };
    assign u_imm = { instr[31:12],{12{1'b0}}};
    assign j_imm = { {11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0};
    
    //various opcodes of a particular instruction types are ORed together
    assign instr_r = opcode_dec[OP]; //R type
    assign instr_i = opcode_dec[OP_IMM] | opcode_dec[JALR] | opcode_dec[LOAD] | opcode_dec[FENCE] | opcode_dec[SYSTEM]; // I type instruction
    assign instr_s = opcode_dec[STORE]; // S type
    assign instr_b = opcode_dec[BRANCH];// B type
    assign instr_u = opcode_dec[LUI] | opcode_dec[AUIPC]; // U type , check if this is usefull
    assign instr_j = opcode_dec[JAL]; // J type 
    
    //Rs1, rs2, rd values are always connected to the reg file. the instr type will determine if they are valid
    assign rs1_addr = instr[19:15];
    assign rs2_addr = instr[24:20];
    assign rd_addr  = instr[11:7];
    
    // rs1 is read for R,I,S,B type instructions
    assign rs1_ren = (instr_r | instr_i | instr_s | instr_b )& en;
    //rs2 is read for R,S,B instructions
    assign rs2_ren = (instr_r | instr_s | instr_b) &en;
    
    always_comb
    begin
        case(instr[6:2])
        OP_IMM,JALR,LOAD,FENCE,SYSTEM : imm_mux = i_imm;
        STORE: imm_mux = s_imm;
        BRANCH: imm_mux = b_imm;
        LUI,AUIPC : imm_mux = u_imm;
        JAL : imm_mux = j_imm;
        default : imm_mux = 0;
        
        endcase
    end
    
    // the B instr requires rs1 and rs2 as operands and simultaneously the imm value is required by the IF unit 
    always_ff @(posedge clk or negedge reset)
    begin
        if (reset ==0)
            imm_val <=0;
        else
           if (en)
            imm_val <= imm_mux; 
    end
    
    
    // the respective operand 0 and operand 1 for the current instrucntion is decoded to be sent to the execute stage
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset ==0)
        begin
            operand_0 <= 0;
            operand_1 <= 0;
        end
        else 
        begin
            if (en)
            begin
                // operand0
                if (opcode_dec[AUIPC])
                    operand_0 <= pc;
                else
                    operand_0 <= rs1;
                //opeand1
                if ( instr_r | instr_b)
                    operand_1 <= rs2;       // Reg- Reg type instr
                else
                    operand_1 <= imm_mux;    //Immediate type instr
                 
            end
        end
    end
    
    // registering rs2 output 
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset == 0)
            rs2_out <=0;
        else
        begin
            if (en)
            begin
                rs2_out <= rs2;
            end
        end
    end
    
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset ==0)
            Instr_Decode_done <= 0;
        else
            Instr_Decode_done <= en; //it just delays the ID enable signal by one clock and gives that as a Decode done signal
    end
    
    decoder opcode (clk,en,reset,instr[6:2],opcode_dec,opcode_dec_ff);
    decoder #(.INPUT(3), .OUT(8)) funct3 (clk,en,reset,instr[14:12],funct3_dec,funct3_dec_ff);
    //decoder #(.INPUT(7), .OUT(128)) funct7 (clk,en,reset,instr[31:25],funct7_dec,funct7_dec_ff); not required since this field is rarely used. 
                                                                                                 //Even then only 5th and 0th bit are used.
    
    
    
endmodule
