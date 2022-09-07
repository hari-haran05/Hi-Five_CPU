`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2022 08:30:43
// Design Name: 
// Module Name: Data_Memory
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


module Memory #( parameter WORD_LN = 32, parameter ADDR_LN = 3)
(
    input clk,
    input wr_en,
    input rd_en,
    input [WORD_LN -1 :0] wr_data,
    input [ADDR_LN-1:0] wr_address,
    input [ADDR_LN-1:0] rd_address,
    output logic [WORD_LN-1:0] rd_data,
    input mem_en,
    input reset
    
    );
    parameter MEM_SIZE = 8;
    logic [WORD_LN -1 :0] data_array [0:MEM_SIZE-1] ;
    int i;
    
    initial 
        $readmemh("data_mem.mem", data_array);
        
        
    always_ff @( posedge clk )
       begin 
            if ( mem_en & wr_en )
                data_array[wr_address] <= wr_data;    
            if ( mem_en & rd_en )
                rd_data <= data_array[rd_address];  
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
