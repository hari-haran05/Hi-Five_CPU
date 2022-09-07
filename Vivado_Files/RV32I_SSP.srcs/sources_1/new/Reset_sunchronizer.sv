`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2022 21:02:55
// Design Name: 
// Module Name: Reset_sunchronizer
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

// two ff reset synchronizer
module Reset_synchronizer(
    input hard_reset,
    input clk,
    //output reg reset_sync =1
    output reset_db,
    output control_unit_en
    );
    //reg sync_0 =1; 
    reg db_0 =0, db_1 =0;
    //wire hard_reset_db;
    reg counter[0:22] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};//{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg counter_edge_reg =0;
    /*assign hard_reset_db = db_0 & db_1; //~db_0 & ~db_1
    always_ff @(posedge clk or posedge hard_reset_db )
    begin
        if (hard_reset_db == 1)
        begin
            sync_0      <= 0;
            reset_sync  <= 0;
        end
        else
        begin
            sync_0      <= 1;
            reset_sync  <= sync_0;
        end
    end  
    */
    // control unit enable pulse signal. 5M input clk is divided to 1Hz using decade counter. A pos edge detection circuit is made for this output clk to get a pulse for every 1s
    
    assign control_unit_en = counter[0] & (~counter_edge_reg ) ;
    
    always_ff @ (posedge clk or negedge reset_db)
    begin
        if (reset_db ==0)
            counter_edge_reg <= 0;
         else
            counter_edge_reg <= counter[0];
    end
    assign reset_db = db_1;
    // lower 32 ff for the counter 31 to 1st ff will the negation of the precceding ff as its clock input 
    genvar i;
    
    for (i =23; i> 0; i=i-1)
    begin
        always_ff @( posedge counter[i-1])
        begin
           counter[i] <= ~counter[i];
        end 
    end
        
    // the lsb ff will have the input clk as its clock. 
    always_ff @(posedge clk )
    begin 
        counter[0] <= ~counter[0];
    end 
    
    // for debouncing , input clk = 5M, out clk = 200Hz, -> divder = ~25000 -> 15 bit counter 
    always_ff @ (posedge counter[14] )
    begin
        db_0 <= hard_reset;
        db_1 <= ~db_0;          //push button is activeHigh but we need active low reset 
    end
    
endmodule
