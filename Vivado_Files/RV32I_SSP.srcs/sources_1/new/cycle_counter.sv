`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2022 09:57:02
// Design Name: 
// Module Name: cycle_counter
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

    this is a 64b cycle counter 
    Timer_con is a the timer configuration register -   bit0 - start , this bit is enough
                                                        bit2 - stop    no need of this stop bit 
                                                        bit4 - reset   active High reset of the counter
    cycle_l and cycle_h are the low and high words of the 64b timer 
*/

module cycle_counter(
    input clk,
    input cpu_reset ,
    input timer_con_wen,
    input [31:0] timer_con_wdata,
    output logic [31:0] timer_con =0,
    output logic [31:0] cycle_h_out,
    output logic [31:0] cycle_l_out 
    
    );
    
    wire reset,counter_en;
    assign reset = cpu_reset & (~timer_con[4]);          // 4th bit of the timer_con register can be cleared to reset the counter
    assign counter_en = timer_con[0]; // the 0th bit ( start bit) should be set and the 2nd bit (stop bit) should be cleared to enable the timer 
    reg cycle_l[0:31] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg cycle_h[0:31] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    
    
    // lower 32 ff for the counter 31 to 1st ff will the negation of the precceding ff as its clock input 
    genvar i;
    
    for (i =31; i> 0; i=i-1)
    begin
        always_ff @( posedge (~cycle_l[i-1]) or negedge reset)
        begin
            if (reset ==0)
                cycle_l[i] <=0;
            else
                if (counter_en)
                    cycle_l[i] <= ~cycle_l[i];
        end 
    end
    // the lsb ff will have the input clk as its clock. 
    always_ff @(posedge clk or negedge reset )
    begin 
        if (reset ==0)
            cycle_l[0] <=0;
        else 
            if (counter_en)
                cycle_l[0] <= ~cycle_l[0];
    end 
    
    // repeating for cycle_h. cycle_h[0] will have ~cycle_l[31] as its clock
    // lower 32 ff for the counter 31 to 1st ff will the negation of the precceding ff as its clock input  
    for (i =31; i> 0; i=i-1)
    begin
        always_ff @( posedge (~cycle_h[i-1]) or negedge reset)
        begin
            if (reset ==0)
                cycle_h[i] <=0;
            else
                if (counter_en)
                    cycle_h[i] <= ~cycle_h[i];
        end 
    end
    //  
    always_ff @(posedge (~cycle_l[31]) or negedge reset )
    begin 
        if (reset ==0)
            cycle_h[0] <=0;
        else 
            if (counter_en)
                cycle_h[0] <= ~cycle_h[0];
    end 
    
    for ( i=0; i <32; i=i+1)
    begin
        assign cycle_h_out[i] = cycle_h[i]; 
        assign cycle_l_out[i] = cycle_l[i];        
    end
     
    //timer_con register 
    always_ff @(posedge clk or negedge reset )
    begin 
        if (reset ==0)
            timer_con <= 0 ;
        else 
            if (timer_con_wen)
                timer_con <= timer_con_wdata;
       
    end
    
endmodule
