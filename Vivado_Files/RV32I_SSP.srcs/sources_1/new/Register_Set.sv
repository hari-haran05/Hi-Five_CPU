`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2022 00:40:00
// Design Name: 
// Module Name: Register_Set
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


module Register_Set(
    input clk,
    input reset,
    input en,
    input logic [4:0] rs1_addr,
    input logic [4:0] rs2_addr,
    input logic [4:0] rd_addr,
    //input rs1_ren,
    //input rs2_ren,
    input IF_rd_wen,
    input ALU_rd_wen,
    input CSU_rd_wen,
    input LSU_rd_wen,
    input logic [4:0] opcode,
    input logic [31:0] IF_rd_data,
    input logic [31:0] ALU_rd_data,
    input logic [31:0] CSU_rd_data,
    input logic [31:0] LSU_rd_data,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
    );
    
    parameter JAL = 5'b11011;
    parameter JALR = 5'b11001;
    parameter LUI = 5'b01101;
    parameter AUIPC = 5'b00101;
    parameter LOAD  = 5'b00000;
    parameter OP_IMM = 5'b00100;
    parameter OP = 5'b01100;
    parameter CSU = 5'b11100;
    
    logic [31:0] rd_data;
    logic rd_wen;
    wire x0_rd,x0_rs1,x0_rs2,x0;
    wire [31:0] rs1_unreg_data;
    wire [31:0] rs2_unreg_data;
    
    assign x0       = 32'h0x00;         //X0 register is hardwired to 0
   // assign x0_rd  = ( rd_addr == 5'h0x0);
    //assign x0_rs1 = (rs1_addr == 5'h0x0);
    //assign x0_rs2 = (rs2_addr == 5'h0x0); 
    //assign rd_wen = (IF_rd_wen | ALU_rd_wen | CSU_rd_wen | LSU_rd_wen) & (~x0_rd); // if the dest addr is register x0, do not write the data to the reg file
                                                                                   // rather, it should be discarded
   // assign rs1_data = (rs1_addr == 5'h0x0) ? 32'h0x00: rs1_reg_data;    // if rs1 addr is x0, the value is always 0 
    //assign rs2_data = (rs2_addr == 5'h0x0) ? 32'h0x00: rs2_reg_data;    // " " " " "
    
    
    always_comb
    begin
        case (opcode)
        JAL,
        JALR:       
            begin
            rd_data <= IF_rd_data;
            end
        LOAD,LUI: 
        begin
            rd_data <= LSU_rd_data;
        end
        AUIPC,OP_IMM,OP:
        begin
            rd_data <= ALU_rd_data;
        end
        CSU:
        begin
            rd_data<= CSU_rd_data;
        end
        default : rd_data <=0;
        endcase
    end
    
    always_comb
    begin
      if (rd_addr == 5'b00000)
        rd_wen <= 0;
      else
      begin
        case (opcode)
        JAL,
        JALR:       
            begin
            rd_wen  <= IF_rd_wen;
            end
        LOAD,LUI: 
        begin
            rd_wen <= LSU_rd_wen;
        end
        AUIPC,OP_IMM,OP:
        begin
            rd_wen  <= ALU_rd_wen;
        end
        CSU:
        begin
            rd_wen <= CSU_rd_wen;
        end
        default : rd_wen <=0;
        endcase
      end

    end
    
    always_comb
    begin
        if ( rs1_addr == 5'b00000)
            rs1_data = 32'h0x00000000;
        else
            rs1_data = rs1_unreg_data;
    end
    
     always_comb
    begin
        if ( rs2_addr == 5'b00000)
            rs2_data = 32'h0x00000000;
        else
            rs2_data = rs2_unreg_data;
    end
    
    Register_file Reg_file(clk,
    reset,
    rs1_addr,
    rs2_addr,
    rd_addr,
    //rs1_ren,
    //rs2_ren,
    rd_wen,
    rd_data,
    rs1_unreg_data,
    rs2_unreg_data
    );
    
endmodule
