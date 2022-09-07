`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2022 14:20:59
// Design Name: 
// Module Name: Multiplier
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


module Multiplier(
    input clk,
    input en,
    input reset,
    input logic [31:0] operand_0,
    input logic [31:0] operand_1,
    output logic [31:0] mult,
    output logic done =0
    );
    
    wire [15:0] a0;
    
    wire [15:0] b0 = operand_1[15:0];
    wire [15:0] a1 = operand_0[31:16];
    wire [15:0] b1 = operand_1[31:16];
    wire [31:0] a1b0_val;
    wire [31:0] a0b1_val;
    wire [31:0] a0b0_val;
    wire [31:0] a0b1_a1b0;
    wire [31:0] a0b1_a1b0_shifted = {a0b1_a1b0[15:0] , {16{1'b0}}};
    wire f_carry_out;
    
    reg en_buf_0 =0, en_buf_1 =0;
    
    assign a0 = operand_0[15:0];
    assign b0 = operand_1[15:0];
    assign a1 = operand_0[31:16];
    assign b1 = operand_1[31:16];
    //assign reset_n = ~reset;    //the macros expect a posedge reset , but the reset of the design uses negedge 

    /*
    MULT_MACRO #(
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .LATENCY(1),        // Desired clock cycle latency, 0-4
      .WIDTH_A(16),       // Multiplier A-input bus width, 1-25
      .WIDTH_B(16)
   ) A0B0 (
      .P(a0b0_val),     // Multiplier output bus, width determined by WIDTH_P parameter
      .A(a0),     // Multiplier input A bus, width determined by WIDTH_A parameter
      .B(b0),     // Multiplier input B bus, width determined by WIDTH_B parameter
      .CE(en),   // 1-bit active high input clock enable
      .CLK(clk), // 1-bit positive edge clock input
      .RST(reset_n)  // 1-bit input active high reset
   );
   
   
   MULT_MACRO #(
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .LATENCY(1),        // Desired clock cycle latency, 0-4
      .WIDTH_A(16),       // Multiplier A-input bus width, 1-25
      .WIDTH_B(16)
   ) A1B0 (
      .P(a1b0_val),     // Multiplier output bus, width determined by WIDTH_P parameter
      .A(a1),     // Multiplier input A bus, width determined by WIDTH_A parameter
      .B(b0),     // Multiplier input B bus, width determined by WIDTH_B parameter
      .CE(en),   // 1-bit active high input clock enable
      .CLK(clk), // 1-bit positive edge clock input
      .RST(reset_n)  // 1-bit input active high reset
   );
   
   MULT_MACRO #(
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .LATENCY(1),        // Desired clock cycle latency, 0-4
      .WIDTH_A(16),       // Multiplier A-input bus width, 1-25
      .WIDTH_B(16)
   ) A0B1 (
      .P(a0b1_val),     // Multiplier output bus, width determined by WIDTH_P parameter
      .A(a0),     // Multiplier input A bus, width determined by WIDTH_A parameter
      .B(b1),     // Multiplier input B bus, width determined by WIDTH_B parameter
      .CE(en),   // 1-bit active high input clock enable
      .CLK(clk), // 1-bit positive edge clock input
      .RST(reset_n)  // 1-bit input active high reset
   );
   */
  /* 
   ADDSUB_MACRO #(
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .LATENCY(0),        // Desired clock cycle latency, 0-2
      .WIDTH(32)          // Input / output bus width, 1-48
   ) A0B1_A1B0_SUM (
      .CARRYOUT(carry_out), // 1-bit carry-out output signal
      .RESULT(a0b1_a1b0),     // Add/sub result output, width defined by WIDTH parameter
      .A(a0b1_val),               // Input A bus, width defined by WIDTH parameter
      .ADD_SUB(1'b1),   // 1-bit add/sub input, high selects add, low selects subtract
      .B(a1b0_val),               // Input B bus, width defined by WIDTH parameter
      .CARRYIN(1'b0),   // 1-bit carry-in input
      .CE(en),             // 1-bit clock enable input
      .CLK(clk),           // 1-bit clock input
      .RST(reset_n)            // 1-bit active high synchronous reset
   );
   
   ADDSUB_MACRO #(
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .LATENCY(0),        // Desired clock cycle latency, 0-2
      .WIDTH(32)          // Input / output bus width, 1-48
   ) MULTIPLY (
      .CARRYOUT(f_carry_out), // 1-bit carry-out output signal
      .RESULT(mult),     // Add/sub result output, width defined by WIDTH parameter
      .A(a0b1_a1b0_shifted),               // Input A bus, width defined by WIDTH parameter
      .ADD_SUB(1'b1),   // 1-bit add/sub input, high selects add, low selects subtract
      .B(a0b0_val),               // Input B bus, width defined by WIDTH parameter
      .CARRYIN(carry_out),   // 1-bit carry-in input
      .CE(en),             // 1-bit clock enable input
      .CLK(clk),           // 1-bit clock input
      .RST(reset_n)            // 1-bit active high synchronous reset
   );
   */
   //assign a0b1_a1b0 = a0b1_val + a1b0_val;
   //assign mult = a0b1_a1b0_shifted + a0b0_val;
   assign mult = operand_0 * operand_1;
   
   always_ff @(posedge clk or negedge reset )
   begin
        if (reset ==0)
        begin
            en_buf_0 <=0;
            done <=0;
        end
        else
        begin
            en_buf_0 <= en;
            done <= en_buf_0;
        end
   end
   
endmodule
