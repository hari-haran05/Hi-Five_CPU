`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2020 11:52:50 AM
// Design Name: 
// Module Name: UartTestBench
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


module UartTestBench( );

reg clk=0,TxCmd=0;
reg Rx =1'b1;
reg [7:0] TxData = 8'h0;
wire RxD,Tx,TxBusy,TxDone;
wire [7:0] RxData;
reg [7:0] TxDataTest [0:3] ;

parameter START = 2'b00;
parameter DATA = 2'b01;
parameter STOP  = 2'b10;
parameter clk_per_bit = 8680;

reg [7:0] RxDataTest = 8'haa;
reg [1:0] SM =2'b0; reg [2:0] index=0;
reg [1:0] i=0;

UartRx RxM(clk,Rx,RxD,RxData);
UartTx TxM(clk,TxCmd,TxData,TxBusy,TxDone,Tx);

initial
begin
TxDataTest [0]<= 8'h55;
TxDataTest [1]<= 8'haa;
TxDataTest [2]<= 8'h77;
TxDataTest[3] <= 8'hcc;
end

always @(posedge clk)
begin 

    begin
        wait (TxBusy ==1'b0);
        TxCmd <=1'b1;
        TxData <= TxDataTest[i];
        @(posedge clk);
        TxCmd <=1'b0;
        @(posedge clk);
        @(negedge TxBusy);
        i=i+1;
        //TxCmd <=1'b0; 
    end
  
     
      // Tell UART to send a command (exercise Tx)
      @(posedge clk);
      @(posedge clk);
      TxCmd <= 1'b1;
      TxData <= 8'hAB;
      @(posedge clk);
      TxCmd <= 1'b0;
      @(posedge TxDone);
      
end

// 100 Mhz clk
always #5 clk=~clk;

always @( posedge clk) 
begin 
case (SM)

START :
begin
Rx <= 1'b0;
SM <= DATA;
#clk_per_bit;
end
DATA :
begin
Rx <= RxDataTest[index];
if (index <7)
    index<=index +1;
else 
begin
    index <=0;
    SM<=STOP;
end 
#clk_per_bit;
   
end

STOP :
begin 
    Rx <=1'b1;
    #clk_per_bit;
    SM<=START;
end
endcase
end
/*
initial
begin
    

end
*/

endmodule
