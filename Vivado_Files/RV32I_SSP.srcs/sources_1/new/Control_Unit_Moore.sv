`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2022 18:32:24
// Design Name: 
// Module Name: Control_Unit_Moore
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


module Control_Unit_Moore(
    input clk,
    input reset,
    input CPU_halt,
    input en,
    input logic [2:0] Done,
    output logic[2:0] enable
    );
    
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    parameter S4 = 3'b100;
    
    
    reg IF_en , ID_en, IE_en;
    reg [1:0] next_state;
    reg [1:0] current_state =0; 
    wire IF_done,ID_done,IE_done;
    
    assign IF_done = Done[2];
    assign ID_done = Done[1];
    assign IE_done = Done[0];
    assign enable  = {IF_en,ID_en,IE_en};
    
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset ==0)
            current_state   <= 0;
        else
            if (en)
            begin
                current_state   <= next_state;
            end
    end
    
    //next state and output variables
    always_comb
    begin
        case (current_state)
        S0:
        begin
            
            IF_en       <= 0;
            ID_en       <= 0;
            IE_en       <= 0;
            if (CPU_halt == 0)
            begin
                next_state  <= S1;
            end
            else
            begin
                next_state  <= S0;
            end
        end
        S1:
        begin
            IF_en       <= 1;
            ID_en       <= 0;
            IE_en       <= 0;
            if (IF_done == 0 )
            begin
                next_state  <= S1;             
            end
            else 
            begin
                next_state  <= S2;
                
            end
        end
        S2:
        begin
            IF_en       <= 0;
            ID_en       <= 1;
            IE_en       <= 0;    
            if (ID_done == 0 )
            begin
                next_state  <= S2;                 
            end
            else 
            begin
                next_state  <= S3;
                
            end
        end
        S3:
        begin
            IF_en       <= 0;
            ID_en       <= 0;
            IE_en       <= 1;
            if (CPU_halt)
            begin
                next_state  <= S0;
            end
            else
            begin
                if (IE_done == 0 )
                begin
                    next_state  <= S3;
                end
                else 
                begin
                    next_state  <= S1;
                    
                end
            end
        end
        endcase
    end
    
    
endmodule

