`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2022 14:23:07
// Design Name: 
// Module Name: Load_Store_Unit
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


module Load_Store_Unit #(parameter ADDR_LN = 8, parameter WORD_LN = 32)
(
    input clk,
    input en,
    input reset,
    input [31:0] sum,
    input [2:0] funct3,
    input [31:0] opcode_dec,
    input [31:0] operand_1,
    input [WORD_LN-1:0] mem_rd_data,
    input [WORD_LN-1:0] reg_rd_data,
    input mem_store_valid,
    output [ADDR_LN-1:0] mem_rd_word_addr,
    output [ADDR_LN-1:0] mem_wr_word_addr,
    output logic [WORD_LN-1:0] mem_wr_data,
    output mem_rd_en,
    output mem_wr_en,
    output logic [WORD_LN-1:0] reg_wr_data,
    //output mem_en,
    output logic reg_wr_en, 
    output logic done 
    );
    
    //LOAD variables
    wire [31:0]reg_wr_word;
    wire [15:0]reg_wr_halfw;
    wire [15:0]reg_wr_halfw_lsb;
    wire [15:0]reg_wr_halfw_msb;
    logic [7:0]reg_wr_byte;
    wire [7:0]mem_rd_data_byte_0,mem_rd_data_byte_1,mem_rd_data_byte_2,mem_rd_data_byte_3;
    
    // Store variables
    wire [31:0]mem_wr_word;
    wire [31:0]mem_wr_halfw;
    wire [31:0]mem_wr_halfw_lsb;
    wire [31:0]mem_wr_halfw_msb;
    logic[31:0]mem_wr_byte;
    wire [9:0] mem_rd_addr;
    wire [9:0] mem_wr_addr;
    wire [7:0]reg_rd_data_byte_0,reg_rd_data_byte_1,reg_rd_data_byte_2,reg_rd_data_byte_3;
    
    reg en_reg =0;              // to make a pos edge detection with en input 
    wire en_pos_edge;
    
    assign mem_rd_addr = sum[9:0];   // the dest write/read address is calculated by the Adder in Int ALU block.  
    assign mem_wr_addr = sum[9:0];   // the memory address range is 0-255 only. hence only the LSB of the sum input is taken
    assign mem_rd_word_addr = mem_rd_addr[9:2]; //Dmem requires 8b word aligned address
    assign mem_wr_word_addr = mem_wr_addr[9:2];
    assign en_pos_edge = en & (~en_reg);    // pos edge detection on en input signal
    assign mem_rd_en = opcode_dec[0] & en;     //en_pos_edge;   // Load inst
    assign mem_wr_en = opcode_dec[8] & en;    //en_pos_edge;   //Store inst    
    
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset == 0 )
            en_reg <=0;
        else
            en_reg <= en;
    end
    
    /*
    assign reg_wr_word = mem_rd_data[0:31]; // the memory is arranged in Little endian format. hence reversing the data to write to register 
    assign reg_wr_halfw_lsb = mem_rd_data[16:31]; //
    assign reg_wr_halfw_msb = mem_rd_data[0:15];  //
    */
    assign mem_rd_data_byte_0 = mem_rd_data[31:24];     // lsb0 in Little endian format 
    assign mem_rd_data_byte_1 = mem_rd_data[23:16];     // lsb1 in Little endian format 
    assign mem_rd_data_byte_2 = mem_rd_data[15:8];      // lsb2 in Little endian format 
    assign mem_rd_data_byte_3 = mem_rd_data[7:0];       // lsb3 in Little endian format 
    
    assign reg_wr_word = {mem_rd_data_byte_3,mem_rd_data_byte_2,mem_rd_data_byte_1,mem_rd_data_byte_0};//the memory is arranged in Little endian format. hence reversing the data to write to register 
    assign reg_wr_halfw_lsb = {mem_rd_data_byte_1,mem_rd_data_byte_0};
    assign reg_wr_halfw_msb = {mem_rd_data_byte_3,mem_rd_data_byte_2};
    
    //assign mem_en = 1'b1;   // memory always enabled
    
    //selecting the correct half-word within the word fetched accprdng to the address
    assign reg_wr_halfw = mem_rd_addr[1]? reg_wr_halfw_msb:reg_wr_halfw_lsb;  //bit1 deteremines the correct half word within the word 
    
    //address bit 1,0 determines the byte
    always_comb
    begin
        case ({mem_rd_addr[1],mem_rd_addr[0]})
            2'b00: reg_wr_byte = mem_rd_data_byte_0;
            2'b01: reg_wr_byte = mem_rd_data_byte_1;
            2'b10: reg_wr_byte = mem_rd_data_byte_2;
            2'b11: reg_wr_byte = mem_rd_data_byte_3;
            
        endcase
    end
    
    // Load - data, register write
    always_comb
    begin
        case ({opcode_dec[13],funct3})
        4'b1000,
        4'b1001,
        4'b1010,
        4'b1011,
        4'b1100,
        4'b1101,
        4'b1110,
        4'b1111: reg_wr_data = operand_1;
        4'b0000: reg_wr_data = {{24{reg_wr_byte[7]}},reg_wr_byte};
        4'b0001: reg_wr_data = {{16{reg_wr_halfw[15]}}, reg_wr_halfw};
        4'b0010: reg_wr_data = reg_wr_word;
        4'b0100: reg_wr_data = {24'h0x000000,reg_wr_byte}; 
        4'b0101: reg_wr_data = {16'h0x0000, reg_wr_halfw};
        default: reg_wr_data = 32'h0x00000000;
                
        endcase
    end
    
    //reg_write_en signal can be asserted in the next cycle itself
    always_ff @(posedge clk or negedge reset)
    begin
        if (reset == 0)
            reg_wr_en <=0;
         else 
            reg_wr_en <= mem_rd_en;     //check
    end 
    
    /*   Store instruction   */
    
  
    assign reg_rd_data_byte_0 = reg_rd_data[7:0];     // lsb0 in Little endian format 
    assign reg_rd_data_byte_1 = reg_rd_data[15:8];     // lsb1 in Little endian format 
    assign reg_rd_data_byte_2 = reg_rd_data[23:16];     // lsb2 in Little endian format 
    assign reg_rd_data_byte_3 = reg_rd_data[31:24];     // lsb3 in Little endian format 
    
    assign mem_wr_word = {reg_rd_data_byte_0,reg_rd_data_byte_1,reg_rd_data_byte_2,reg_rd_data_byte_3};//the memory is arranged in Little endian format. hence reversing the data to write to register 
    assign mem_wr_halfw_lsb = {reg_rd_data_byte_0,reg_rd_data_byte_1,16'h0x0000};
    assign mem_wr_halfw_msb = {16'h0x0000,reg_rd_data_byte_0,reg_rd_data_byte_1};
        
    //selecting the correct half-word within the word fetched accprdng to the address
    assign mem_wr_halfw = mem_wr_addr[1]? mem_wr_halfw_msb:mem_wr_halfw_lsb;  //bit1 deteremines the correct half word within the word 
    
    //address bit 1,0 determines which byte within the word gets filled 
    always_comb
    begin
        case ({mem_wr_addr[1],mem_wr_addr[0]})
            2'b00: mem_wr_byte = {reg_rd_data_byte_0,24'h0x000000};
            2'b01: mem_wr_byte = {8'h0x00,reg_rd_data_byte_0,16'h0x0000};
            2'b10: mem_wr_byte = {16'h0x0000,reg_rd_data_byte_0,8'h0x00};
            2'b11: mem_wr_byte = {24'h0x000000,reg_rd_data_byte_0};
            
        endcase
    end
    
    // Store instr - mem-wr
    always_comb
    begin
        case(funct3)
            3'b000: mem_wr_data <= mem_wr_byte;
            3'b001: mem_wr_data <= mem_wr_halfw;
            3'b010: mem_wr_data <= mem_wr_word;
            default: mem_wr_data <= 32'h0x00000000;
        endcase
    end
    
    //done signal 
    always_ff @(posedge clk or negedge reset )
    begin
        if ( reset ==0 )
            done <=0;
        else
        begin
            if(opcode_dec[0])
                done <= reg_wr_en;
            else
                done <= mem_store_valid;
        end
    end
    
endmodule
