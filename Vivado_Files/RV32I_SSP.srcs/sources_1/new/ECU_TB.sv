`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2022 14:24:26
// Design Name: 
// Module Name: ECU_TB
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


module ECU_TB();
    parameter ADDR_LN = 8;
    parameter WORD_LN = 32;
    
    reg clk =1;
    reg en  =0;
    reg reset   =1;
    wire[31:0] mem_rd_data;
    reg [31:0] CSR_wr_data  =0;
    reg  CSR_Transfer_Start_Address_wen = 0;
    reg  CSR_Transfer_End_Address_wen = 0;
    reg  CSR_Transfer_Control_wen    = 0;
    wire   uart_rx;
    wire  uart_tx;
    wire [ADDR_LN-1:0]mem_rd_addr;
    wire mem_rd_en;
    wire [31:0] CSR_Transfer_Start_Address ;
    wire [31:0] CSR_Transfer_End_Address   ;
    wire [31:0] CSR_Transfer_Control;
    wire mem_master_sel;

    reg [WORD_LN-1:0] ctr_wr_data =0;
    reg [ADDR_LN -1 :0] ctr_wr_addr =0;
    reg ctr_wr_en =0;
    reg cpu_rd_en =0;
    wire [WORD_LN-1:0]cpu_rd_data;
    reg [ADDR_LN-1:0] cpu_rd_addr =0;
    wire mem_wr_valid;
    
External_Controller_Unit ECU (
    clk,
    en,
    reset ,
    mem_rd_data,
    CSR_wr_data,
    CSR_Transfer_Start_Address_wen,
    CSR_Transfer_End_Address_wen,
    CSR_Transfer_Control_wen,
    uart_rx,
    uart_tx,
    mem_rd_addr,
    mem_rd_en,
    CSR_Transfer_Start_Address ,
    CSR_Transfer_End_Address,
    CSR_Transfer_Control,
    mem_master_sel
);


data_Memory Data_Mem (
    clk,
    reset,
    ctr_wr_data,
    ctr_wr_addr,
    ctr_wr_en,
    ctr_wr_data,        // Mem write is not tested in this module 
    ctr_wr_addr,
    ctr_wr_en,
    cpu_rd_en,
    cpu_rd_data,
    cpu_rd_addr,
    mem_rd_en,
    mem_rd_data,
    mem_rd_addr,
    1'b1,
    1'b1,
    mem_master_sel,
    mem_wr_valid
);


always #5 clk <= ~clk;

initial
begin
    #10;
    reset <= 0;
    #10;
    reset <= 1;
    #11;
    
    // giving Start and End address 
    en  <= 1;
    CSR_wr_data <= 8'h0x02;
    CSR_Transfer_Start_Address_wen  <= 1;
    #10;
    CSR_wr_data <=  8'h0x09;
    CSR_Transfer_Start_Address_wen  <=0;
    CSR_Transfer_End_Address_wen    <=1;
    #10;
    CSR_wr_data <=  8'h0x01;
    CSR_Transfer_Start_Address_wen  <=0;
    CSR_Transfer_End_Address_wen    <=0;
    CSR_Transfer_Control_wen        <=1;
    #10;
    CSR_Transfer_Control_wen        <=0;
    wait(CSR_Transfer_Control[4] == 0);
    $stop;
    
end


endmodule
