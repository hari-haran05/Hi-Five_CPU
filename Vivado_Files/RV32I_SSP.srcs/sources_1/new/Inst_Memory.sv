`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2022 08:22:28
// Design Name: 
// Module Name: Inst_Memory
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


module Inst_Memory#(parameter WORD_LN = 32, parameter ADDR_LN = 8)
(
    input clk,
    input [WORD_LN-1:0] ctr_wr_data,
    input [ADDR_LN -1 :0] ctr_wr_addr,
    input ctr_wr_en,
    input cpu_rd_en,
    output logic [WORD_LN-1:0] cpu_rd_data,
    input [9: 0] cpu_rd_addr,
    input cpu_mem_en,
    input ctr_mem_en,
    output logic cpu_rd_valid,
    output logic ctr_wr_ack
    
    );
    
  parameter MEM_SIZE = 256;
    (* ram_style = "block" *)reg [WORD_LN -1 :0] instr_mem_array [0:MEM_SIZE-1] ;
    int i;
    wire [7:0] cpu_rd_word_addr;
    
    assign mem_en = cpu_mem_en | ctr_mem_en;
    assign cpu_rd_word_addr = cpu_rd_addr[9:2];
    
    initial 
        $readmemh("inst_mem.mem", instr_mem_array);
        
        
    always_ff @( posedge clk )
       begin 
            if ( mem_en & ctr_wr_en )
            begin
                instr_mem_array[ctr_wr_addr] <= ctr_wr_data;
                ctr_wr_ack = 1'b1;
            end
            else
                ctr_wr_ack = 1'b0;  
            if ( mem_en & cpu_rd_en )
            begin
                cpu_rd_data <= instr_mem_array[cpu_rd_word_addr];  
                cpu_rd_valid <=1'b1;
            end
            else
                cpu_rd_valid <= 1'b0;
       end
    
    
    /*
     BRAM_SINGLE_MACRO #(.READ_WIDTH(32), .WRITE_WIDTH(32)) Data_Memory (
      .DO(rd_data),       // Output data, width defined by READ_WIDTH parameter
      .ADDR(address),   // Input address, width defined by read/write port depth
      .CLK(clk),     // 1-bit input clock
      .DI(wr_data),       // Input data port, width defined by WRITE_WIDTH parameter
      .EN(mem_en),       // 1-bit input RAM enable
      .REGCE(mem_en), // 1-bit input output register enable
      .RST(reset),     // 1-bit input reset
      .WE(wr_en)        // Input write enable, width defined by write port depth
   );
*/
       
    
    
    
    
endmodule
