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


module Data_Memory#(parameter WORD_LN = 32, parameter ADDR_LN = 8)
(
    input clk,
    input [WORD_LN-1:0] ctr_wr_data,
    input [ADDR_LN -1 :0] ctr_wr_addr,
    input ctr_wr_en,
    input [WORD_LN-1:0] cpu_wr_data,
    input [ADDR_LN -1 :0] cpu_wr_addr,
    input cpu_wr_en,
    input cpu_rd_en,
    output logic [WORD_LN-1:0] cpu_rd_data,
    input [ADDR_LN -1: 0] cpu_rd_addr,
    input ctr_rd_en,
    output logic [WORD_LN-1:0] ctr_rd_data,
    input [ADDR_LN -1: 0] ctr_rd_addr,
    input cpu_mem_en,
    input ctr_mem_en,
    input master_sel
    
    );
    
  parameter MEM_SIZE = 256;
    logic [WORD_LN -1 :0] data_array [0:MEM_SIZE-1] ;
    int i;
    logic [ADDR_LN-1: 0 ] wr_addr;
    logic [WORD_LN-1: 0 ] wr_data;
    logic wr_en;
    
     assign mem_en = master_sel ? cpu_mem_en : ctr_mem_en;
     assign  wr_addr = master_sel ? cpu_wr_addr : ctr_wr_addr;
     assign  wr_data = master_sel ? cpu_wr_data : ctr_wr_data;
     assign  wr_en = master_sel? cpu_wr_en: ctr_wr_en;
     
     logic [ADDR_LN-1: 0 ] rd_addr;
     logic [WORD_LN-1: 0 ] rd_data;
     logic rd_en;
     assign  rd_addr = master_sel ? cpu_rd_addr : ctr_rd_addr;
     assign  rd_data = master_sel ? cpu_rd_data : ctr_rd_data;
     assign  rd_en = master_sel? cpu_rd_en: ctr_rd_en;
 
 
 
    //initial 
      //  $readmemh("data_mem.mem", data_array);
        
        
    always_ff @( posedge clk )
       begin 
            if ( mem_en & wr_en )
                data_array[wr_addr] <= wr_data;    
            if ( mem_en & rd_en )
                rd_data <= data_array[rd_addr];  
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
