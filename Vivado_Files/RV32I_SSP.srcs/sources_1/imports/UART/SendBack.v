`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2020 03:02:39 PM
// Design Name: 
// Module Name: SendBack
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


module SendBack(
    input clk,
    input Rx,
    output Tx,
    output reg RxDone,
    output TxDone,
    output TxBusy
    );
    
    wire RxD;
    wire TxCmd = (RxD & (~TxBusy));
    wire [7:0] RxData;
    reg [7:0]TxData;
    UartRx RxM(clk,Rx,RxD,RxData);
    UartTx TxM(clk,TxCmd,RxData,TxBusy,TxDone,Tx);
    
    always @(posedge RxD)
        RxDone =~RxDone;
    
endmodule
