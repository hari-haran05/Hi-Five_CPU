`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2022 23:15:47
// Design Name: 
// Module Name: Inst_Decoder_Reg_FIle_TB
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


module Inst_Decoder_Reg_FIle_TB();
   
   // instructions  
    parameter ADD = 32'h0x00308333;
    parameter SUB = 32'h0x41238F33;
    parameter SLTI =32'h0x2DA22D93;
    parameter SLLI = 32'h0x004C9813;
    parameter SW    = 32'h0x03372CA3;
    parameter BLT   = 32'h0xF1374E63;
    parameter LUI   =32'h0xFABECAB7;
    parameter JAL   = 32'h0x80100B6F;
    parameter SLTI_N = 32'h0xADA25D93;
    parameter TOTAL_INSTR = 7;
   // loop interger
   //int i =0;
   
    logic [31:0] instr =0;
    logic clk = 1;
    logic reset =1;
    logic ID_en =0;
    wire ID_done;
    // Inst_decoder signals
    
    logic [31:0]opcode_dec;
    logic [7:0] funct3_dec;
    logic [127:0] funct7_dec;
    logic [31:0] imm_val;
    logic [4:0] rs1_addr;
    logic [4:0] rs2_addr;
    logic[4:0] rd_addr;
    logic rs1_ren;
    logic rs2_ren;
    
    //register set signals
    logic IF_rd_wen  =0;
    logic ALU_rd_wen =0;
    logic CSU_rd_wen =0;
    logic LSU_rd_wen =0;
    logic [31:0] IF_rd_data =0;
    logic [31:0] ALU_rd_data =0;
    logic [31:0] CSU_rd_data =0;
    logic [31:0] LSU_rd_data =0;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    
    //Module instantiation 
    Inst_Decoder ID_test(instr,
    clk,
    reset,
    ID_en,
    opcode_dec,
    funct3_dec,
    funct7_dec,
    imm_val,
    rs1_addr,
    rs2_addr,
    rd_addr,
    rs1_ren,
    rs2_ren,
    ID_done
    );
    
    Register_Set reg_file(
    clk,
    reset,
    ID_en,
    rs1_addr,
    rs2_addr,
    rd_addr,
    rs1_ren,
    rs2_ren,
    IF_rd_wen,
    ALU_rd_wen,
    CSU_rd_wen,
    LSU_rd_wen,
    instr[6:2],
    IF_rd_data,
    ALU_rd_data,
    CSU_rd_data,
    LSU_rd_data,
    rs1_data,
    rs2_data
    );
    
   always #5  clk <= ~clk; 
    
    initial
    begin
        #10;            // wait some time initially
        reset <=0;      // reset the blocj
        #10;
        reset <= 1;     // remove reset 
        #11;
        // first Decode instruction
       // for ( i=0;i <TOTAL_INSTR; i++)
        
        ID_en <=1;
        instr <= ADD;
        #10;
        ID_en <=0;
        #10;
        //$stop;
        // instr 2
         ID_en <=1;
        instr <= SUB;
        #10;
        ID_en <=0;
        #10;
        //$stop;
        //instr 3
         ID_en <=1;
        instr <= SLTI;
        #10;
        ID_en <=0;
        #10;
        
        //instr4
         ID_en <=1;
        instr <= SLLI;
        #10;
        ID_en <=0;
        #10;
        
        //5
         ID_en <=1;
        instr <= SW;
        #10;
        ID_en <=0;
        #10;
        
        //6
         ID_en <=1;
        instr <= BLT;
        #10;
        ID_en <=0;
        #10;
        //7
         ID_en <=1;
        instr <= LUI;
        #10;
        ID_en <=0;
        #10;
        
        ID_en <=1;
        instr <= JAL;
        #10;
        ID_en <=0;
        #10;
        
        
        ID_en <=1;
        instr <= SLTI_N;
        #10;
        ID_en <=0;
        #10;
        
        $finish;
        
    end
    

endmodule
