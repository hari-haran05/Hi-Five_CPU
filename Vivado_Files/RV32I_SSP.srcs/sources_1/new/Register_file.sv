`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2022 00:18:46
// Design Name: 
// Module Name: Register_file
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


module Register_file(
    input clk,
    input reset,
    input logic [4:0] rs1_addr,
    input logic [4:0] rs2_addr,
    input logic [4:0] rd_addr,
    //input rs1_ren,
    //input rs2_ren,
    input rd_wen,
    //input en,
    input logic [31:0] rd_data,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
    
    );
    
    (* ram_style = "block" *)reg [31:0]reg_array [0:31];
    //wire [31:0]rs1_data,rs2_data;
    
    initial
    begin
        $readmemh("reg_mem.mem", reg_array);
    end
    
    always_ff @( posedge clk )
    begin

        if (rd_wen )
        reg_array[rd_addr] <= rd_data;
        /*if (rs1_ren & en)
        rs1_data <= reg_array[rs1_addr];
        if (rs2_ren & en)
        rs2_data <= reg_array[rs2_addr];
        */
    end
    
    assign rs1_data = reg_array[rs1_addr];
    assign rs2_data = reg_array[rs2_addr];
    /*
    reads are not registered. 
    always_ff @(posedge clk or negedge reset )
    begin
        if (reset ==0)
        begin
            rs1_data_ff <= 0;
            rs2_data_ff <= 0;            
        end
        else
        begin
            if (rs1_ren & en)
                rs1_data_ff <= rs1_data;
            if (rs2_ren & en)
                rs2_data_ff <= rs2_data;
        end
    
    end    
    */
    
endmodule
