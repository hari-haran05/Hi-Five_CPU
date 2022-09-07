`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2022 11:32:51
// Design Name: 
// Module Name: External_Controller_Unit
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
/*
    Interfaces with an UART Tx block to transfer data from the data memory within the specified start and end addresses.
    CSR_Transfer_Control Register is used for controlling the transfer - bit0 - starts the transfer
                                                                         bit2 - stops 
                                                                         bit4 - done bit. this indictes that the transfer has been completed
*/

module External_Controller_Unit
#(parameter ADDR_LN = 8)
(
    input   clk,
    input   en,
    input   reset ,
    input   [31:0] mem_rd_data,
    input   [31:0] CSR_wr_data,
    input   CSR_Transfer_Start_Address_wen,
    input   CSR_Transfer_End_Address_wen,
    input   CSR_Transfer_Control_wen,
    input   uart_rx,
    output  uart_tx,
    output  [ADDR_LN -1:0]mem_rd_word_addr,     //word aligned addr
    output  logic mem_rd_en,
    output  logic [31:0] CSR_Transfer_Start_Address =0,
    output  logic [31:0] CSR_Transfer_End_Address   =0,
    output  [31:0] CSR_Transfer_Control,
    output  logic mem_master_sel
    //output  logic uart_tx_tr,
    //output  logic [7:0]uart_tx_data
    );
    
    /* State names*/
    parameter S0    = 3'b000;
    parameter S1    = 3'b001;
    parameter S2    = 3'b010;
    parameter S3    = 3'b011;
    parameter S4    = 3'b100;
    parameter S5    = 3'b101;
    parameter S6    = 3'b110;
    parameter S7    = 3'b111;
    
    
    reg transfer_start =0;
    reg transfer_stop =0;
    reg transfer_done = 0;
    reg transfer_tr =0;
    reg [2:0]loop_count =0;
    reg [2:0]current_state = S0;
    
    
    wire transfer_tr_edge;
    logic transfer_done_n;
    logic [2:0] loop_count_n;
    logic uart_tx_tr;
    wire uart_tx_active;
    wire uart_tx_done;
    logic [ADDR_LN-1:0] mem_rd_addr_n;
    logic [2:0] next_state;
    logic [7:0] uart_tx_data;
    //wire [ADDR_LN-1 : 0]mem_rd_word_addr;   // word aligned addr
    logic[ADDR_LN+1 : 0]mem_rd_addr =0;     //byte aligned addr
    
    // word aligned addr from byte aligned addr
    assign mem_rd_word_addr = mem_rd_addr[9:2];
    //pos edge detection on the transfer_start output  
    assign transfer_tr_edge = transfer_start & (~transfer_tr);
    
    // Since the data in the memory is stored in littel endian format, the read data is reversed and segregates as 4 8bit values to be trasnferred
    always_comb 
    begin
        case (loop_count[1:0])
            2'b00: uart_tx_data     <= mem_rd_data[7:0];         // LSB of the read data is actual the MSB  
            2'b01: uart_tx_data     <= mem_rd_data[15:8];
            2'b10: uart_tx_data     <= mem_rd_data[23:16];
            2'b11: uart_tx_data     <= mem_rd_data[31:24];
        endcase
    end
    
    //UART Tx module instantiation
    UartTx Transmit ( clk,uart_tx_tr, uart_tx_data,uart_tx_active,uart_tx_done,uart_tx);
    
    //state maching register 
    always_ff @(posedge clk or negedge reset) 
    begin
        if (reset ==0 )
        begin
            transfer_tr     <= 0;
            current_state   <= 0;
            loop_count      <= 0;
            mem_rd_addr     <= 0;        
        end
        else
            if(transfer_start)                  //only if the start bit is set the FSM should run and stop when its cleared
            begin
                transfer_tr     <= transfer_start;
                current_state   <= next_state;
                loop_count      <= loop_count_n;
                mem_rd_addr     <= mem_rd_addr_n;
      
            end
    end
    
    // outputs and next state logic
    always_comb 
    begin
        case (current_state)
        S0: 
        begin
            transfer_done_n   <= 0;
            if (~transfer_tr_edge )
            begin
                next_state      <= S0;
                mem_rd_addr_n   <= 0;
                mem_rd_en       <= 0;
                loop_count_n    <= 0;
                uart_tx_tr      <= 0;
                mem_master_sel  <= 1;
            end
            else
            begin
                next_state      <= S1;
                mem_rd_addr_n   <= CSR_Transfer_Start_Address[ADDR_LN-1:0];
                mem_rd_en       <= 0;
                loop_count_n    <= 0;
                uart_tx_tr      <= 0;
                mem_master_sel  <= 0;       //selects ext controller 
            end            
        end
        S1:
        begin
            next_state      <= S2;
            mem_rd_addr_n   <= mem_rd_addr;
            mem_rd_en       <= 1;
            loop_count_n    <= 0;
            uart_tx_tr      <= 0;
            mem_master_sel  <= 0;
            transfer_done_n   <= 0;

        end
        S2:
        begin
            next_state      <= S3;
            mem_rd_addr_n   <= mem_rd_addr;
            mem_rd_en       <= 0;
            loop_count_n    <= 0;
            uart_tx_tr      <= 1;
            mem_master_sel  <= 0;
            transfer_done_n <= 0;
        end
        S3:
        begin
            mem_rd_addr_n   <= mem_rd_addr;
            mem_rd_en       <= 0;
            uart_tx_tr      <= 0;
            mem_master_sel  <= 0;
            transfer_done_n <= 0;
            if (~uart_tx_done)
            begin
                next_state      <= S3;
                loop_count_n    <= loop_count;
            end
            else 
            begin
                next_state      <= S4;
                loop_count_n    <= loop_count + 1;
            end
        end
        S4:
        begin
            mem_rd_en   <= 0;
            mem_master_sel  <= 0;
            transfer_done_n <= 0;
            if (loop_count[2])                      // loop_count[2] is 1 when it reaches values of 4
            begin
                next_state      <= S5;
                mem_rd_addr_n   <= mem_rd_addr + 4;         //word aligned addr increment 
                loop_count_n    <= 0;
                uart_tx_tr      <= 0;
            end
            else
            begin
                next_state      <= S3;
                mem_rd_addr_n   <= mem_rd_addr;
                loop_count_n    <= loop_count;
                uart_tx_tr      <= 1;
            end
        end
        S5:
        begin
            uart_tx_tr      <= 0;
            mem_rd_addr_n   <= mem_rd_addr;
            loop_count_n    <= 0;
            if( mem_rd_addr > CSR_Transfer_End_Address [ADDR_LN-1:0])
            begin
                next_state      <= S6;
                mem_rd_en       <= 0;
                transfer_done_n <= 1;
                mem_master_sel  <= 1;                
            end
            else
            begin
                next_state      <= S2;
                mem_rd_en       <= 1;
                transfer_done_n <= 0;
                mem_master_sel  <= 0;
            end
        end
        S6:
        begin
            mem_rd_en       <= 0;
            loop_count_n    <= 0;
            uart_tx_tr      <= 0;
            if (~transfer_tr_edge)
            begin
                next_state      <= S6;
                mem_master_sel  <= 1;
                transfer_done_n <= 1;
                mem_rd_addr_n     <= 0;
            end
            else
            begin
                next_state      <= S1;
                mem_master_sel  <= 0;
                transfer_done_n <= 0;
                mem_rd_addr_n   <= CSR_Transfer_Start_Address[ADDR_LN-1:0];
            end
        end
        S7:
        begin
            next_state      <= S0;
            mem_rd_addr_n   <= 0;
            mem_rd_en       <= 0;
            loop_count_n    <= 0;
            uart_tx_tr      <= 0;
            mem_master_sel  <= 1;
        end
        endcase
    end

  
    /* CSR registers */
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset == 0)
        begin
            CSR_Transfer_Start_Address <=0 ;
            CSR_Transfer_End_Address <= 0;
      
        end
        else 
        begin
            if (CSR_Transfer_Start_Address_wen)
                CSR_Transfer_Start_Address <= CSR_wr_data;
            if (CSR_Transfer_End_Address_wen)
                CSR_Transfer_End_Address <= CSR_wr_data;
        end 
    end 
    /* Only the three bits of the control register is implemented as individual FFs to avoid wasting 32b register resource */
    always_ff @ (posedge clk or negedge reset )
    begin
        if (reset ==0)
        begin
            transfer_start <=0;
            transfer_stop  <=0;
            transfer_done  <=0;
        end
        else
        begin
            if (CSR_Transfer_Control_wen)
            begin
                transfer_start  <=   CSR_wr_data[0];
                transfer_stop   <=   CSR_wr_data[2]; 
            end
            transfer_done   <= transfer_done_n;
        end
    
    end
    
    assign CSR_Transfer_Control     = {{27{1'b0}},transfer_done,1'b0,transfer_stop,1'b0,transfer_start};
        
endmodule
