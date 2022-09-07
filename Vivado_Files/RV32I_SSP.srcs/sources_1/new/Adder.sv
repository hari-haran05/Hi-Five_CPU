`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2022 14:08:40
// Design Name: 
// Module Name: Adder
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


module Adder(
    input clk,
    input en,
    input reset,
    input logic [31:0] operand_0,
    input logic [31:0] operand_1,
    input carry_in,
    input add_sub,
    output carry_out,
    //output logic [31:0] sum,
    output [31:0] sum,
    output logic done =0
    );
    

    //assign reset_n = ~reset;    //the macros expect a posedge reset , but the reset of the design uses negedge 
        
    always_ff @(posedge clk or negedge reset)
    begin
        if (reset ==0)
            done <=0;
        else
            done <= en;
    end

    /*   
   ADDSUB_MACRO #(
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .LATENCY(1),        // Desired clock cycle latency, 0-2
      .WIDTH(32)          // Input / output bus width, 1-48
   ) ADDSUB_MACRO_inst (
      .CARRYOUT(carry_out), // 1-bit carry-out output signal
      .RESULT(sum),     // Add/sub result output, width defined by WIDTH parameter
      .A(operand_0),               // Input A bus, width defined by WIDTH parameter
      .ADD_SUB(add_sub),   // 1-bit add/sub input, high selects add, low selects subtract
      .B(operand_1),               // Input B bus, width defined by WIDTH parameter
      .CARRYIN(carry_in),   // 1-bit carry-in input
      .CE(1'b1),             // 1-bit clock enable input
      .CLK(clk),           // 1-bit clock input
      .RST(1'b0)            // 1-bit active high synchronous reset
   );
    
    */
    assign sum = add_sub? (operand_0 + operand_1): (operand_0 - operand_1);
	   
	    
				
endmodule
