`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2022 15:36:56
// Design Name: 
// Module Name: Control_Status_Register_Unit
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


module Control_Status_Register_Unit
#(parameter ADDR_LN = 8, parameter WORD_LN = 32)
(
    input clk,
    input reset ,
    input en,
    input [7:0] funct3_dec,
    input [31:0] operand_0,
    input [31:0] operand_1,
    input [31:0] mem_rd_data,
    input uart_rx,
    output uart_tx,
    output logic [31:0] CSR_rd,
    output rd_en,
    output [ADDR_LN-1:0]mem_rd_addr,
    output mem_rd_en,
    output mem_master_sel,
    output CPU_halt,
    output logic done =0
);
    
    parameter CSR_CYCLE_L_ADDR  = 8'h0x00;
    parameter CSR_CYCLE_H_ADDR  = 8'h0x80;
    parameter CSR_TIMER_CON_ADDR    = 8'h01;
    parameter CSR_SYS_CON_ADDR      = 8'h0xc0;
    parameter CSR_EXT_CTL_CON_ADDR  = 8'h0xE0;
    parameter CSR_TRF_START_ADDR    = 8'h0xE1;
    parameter CSR_TRF_END_ADDR     = 8'h0xE2;
    

    wire [31:0] csr_cycle_l, csr_cycle_h,csr_timer_con,csr_ext_ctl_con,csr_trf_start_addr,csr_trf_end_addr;
    wire CSR_Timer_con_wen;
    wire CSR_Transfer_Start_Address_wen;
    wire CSR_Transfer_End_Address_wen;
    wire CSR_Transfer_Control_wen;
    wire CSR_CPU_Control_wen;
    wire [31:0] CSR_wr_data;
    //wire [31:0] CSR_Regs [0:255];
    wire CSR_addr_C ;
    wire [7:0]CSR_reg_addr;
    logic [255:0]CSR_reg_addr_dec;
    
    reg [31:0] CSR_CPU_Control =0;
    //reg [255:0] CSR_reg_addr_dec_r;


    
    //assign CSR_Regs[7]  = 32'h0x00;  // only 7 CSR regs available
    assign CSR_reg_addr  = operand_1[7:0];
    //assign CSR_rd   = CSR_Regs[CSR_reg_addr];
    assign rd_en    = funct3_dec[1] & en;
    
    assign CPU_halt = CSR_CPU_Control[0];
    assign CSR_addr_C = (operand_1[11:8] == 4'h0xC);
    //CSR write enables
    assign CSR_Timer_con_wen = CSR_reg_addr_dec[1] & rd_en & CSR_addr_C;
    assign CSR_Transfer_Start_Address_wen = CSR_reg_addr_dec[225] & rd_en & CSR_addr_C;
    assign CSR_Transfer_End_Address_wen = CSR_reg_addr_dec[226] & rd_en & CSR_addr_C;
    assign CSR_Transfer_Control_wen = CSR_reg_addr_dec[224] & rd_en & CSR_addr_C;
    assign CSR_CPU_Control_wen = CSR_reg_addr_dec[192] & rd_en & CSR_addr_C;

    
    assign CSR_wr_data = operand_0;
    
    // decoder to decode the CSR reg address
    //decoder #(.INPUT(8), .OUT(256)) CSR_dec (clk,en,reset,CSR_reg_addr,CSR_reg_addr_dec,CSR_reg_addr_dec_r);
    
    always_comb
    begin
        case (CSR_reg_addr)
            CSR_CYCLE_L_ADDR: CSR_rd <= csr_cycle_l;
            CSR_TIMER_CON_ADDR : CSR_rd <= csr_timer_con;
            CSR_CYCLE_H_ADDR: CSR_rd <= csr_cycle_h;
            CSR_EXT_CTL_CON_ADDR : CSR_rd <= csr_ext_ctl_con;
            CSR_TRF_START_ADDR:    CSR_rd <= csr_trf_start_addr;
            CSR_TRF_END_ADDR:      CSR_rd <= csr_trf_end_addr;
            default : CSR_rd <= 32'h0x00000000;
                    
        
        endcase
    end
   
    always_comb 
    begin
        CSR_reg_addr_dec <= 1 <<CSR_reg_addr ;   
    end
    
    cycle_counter cc (
        clk,
        reset ,
        CSR_Timer_con_wen,
        CSR_wr_data,
        csr_timer_con,
        csr_cycle_h,
        csr_cycle_l 
    );


    External_Controller_Unit ECU_UART (
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
        csr_trf_start_addr,
        csr_trf_end_addr,
        csr_ext_ctl_con,
        mem_master_sel
    );
    
    //CPU Control Register
    always_ff @ (posedge clk or negedge reset )
    begin
        if ( reset ==0)
            CSR_CPU_Control <= 0;
        else
            if (CSR_CPU_Control_wen)
                CSR_CPU_Control <= CSR_wr_data;
    
    end
    
   //done signal 
    always_ff @(posedge clk or negedge reset )
    begin
        if ( reset ==0 )
            done <= 0;
        else
        begin
            done <= rd_en;
        end
    end
endmodule
