`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2022 08:15:58
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input en,
    input wire [31:0] next_pc,
    output logic [31:0] pc =0
    );
    
    reg en_reg =0;
    wire en_edge;
    
    //pos edge detection on the input en signal
    // the IE en signal may extend more than 1 clk.since we expect pc to change only once during the instr cycle,
    // we are making an edge detection circuit
    assign en_edge = en & (~en_reg);
    
    always_ff @ (posedge clk or negedge reset)
    begin
        if (reset == 0)
        begin
            pc <= 32'h0x00000000;
            en_reg <= 0;
        end
        else
            if (en_edge)
            begin
                pc <= next_pc;
            end
            en_reg <= en;
    end
   
   
    
endmodule
