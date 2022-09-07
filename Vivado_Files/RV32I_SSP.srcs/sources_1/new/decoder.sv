`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.08.2022 23:21:34
// Design Name: 
// Module Name: decoder
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


module decoder #(parameter INPUT =5 , parameter OUT = 32)(
    input clk,
    input en,
    input reset,
    input [INPUT -1:0] in,
    output logic [OUT-1: 0] out,
    output logic [OUT -1 :0] out_reg =0
    );
    
    
    always_comb 
    begin
         out <= 1<< in;               //out <= 32'h0x00000001 << in;    
    end
    
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset ==0)
            out_reg <=0;
        else 
            if (en)
            out_reg <= out; //32'h0x00000001 << in;
    end
    
endmodule
