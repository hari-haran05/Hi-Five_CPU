`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2022 20:36:10
// Design Name: 
// Module Name: LSU_TB
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


module LSU_TB();


reg clk =1,en=0,reset=1;

    wire [31:0]sum;
    logic [2:0] funct3 = 0;
    logic [31:0] opcode_dec =32'h0x00000000;
    logic [31:0] operand_1 =0;
    logic [31:0] operand_0 =0;
    logic [31:0] mem_rd_data =0;
    logic [31:0] reg_rd_data =0;
    logic  mem_store_valid =0;
    logic [7:0]funct3_dec =0;
    wire [7:0] mem_rd_addr;
    wire [7:0] mem_wr_addr;
    wire [31:0] mem_wr_data;
    wire mem_rd_en;
    wire mem_wr_en;
    wire [31:0] reg_wr_data;
    wire mem_en;
    wire reg_wr_en; 
    wire LSU_done;
    wire ALU_rd_reg;
    wire ALU_rd_en;
    wire ALU_done;

 Load_Store_Unit LSU_DUT (
    clk,
    en,
    reset,
    sum,
    funct3,
    opcode_dec,
    operand_1,
    mem_rd_data,
    reg_rd_data,
    mem_store_valid,
    mem_rd_addr,
    mem_wr_addr,
    mem_wr_data,
    mem_rd_en,
    mem_wr_en,
    reg_wr_data,
    mem_en,
    reg_wr_en, 
    LSU_done 
 );

Arithmetic_logic_Unit ALU_DUT (
    clk,
    reset ,
    en,
    funct3,
    opcode_dec,
    1'b0,
    1'b0,
    funct3_dec,
    operand_0,
    operand_1,
    branch_ctl,
    ALU_rd_reg,
    ALU_rd_en,
    ALU_done,
    sum
);



always #5 clk <= ~clk;


initial
begin
    #10;
    reset <= 0;
    #10;
    reset <= 1;
    #11;
    // Load instr
    //LW - word aligned address. Positive immediate value
    operand_0 <= 32'h0x00000004;
    operand_1 <= 32'h0x00000004; 
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b010;
    funct3_dec  <= 8'h0x04;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    
    #10;
    
    mem_rd_data <= 32'h12345678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;
    #10;
   // $stop;
    /******************/    
    //LW - word aligned address. Negative immediate value
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0xfffffffc;        // -4 
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b010;
    funct3_dec  <= 8'h0x04;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    
    #10;
    
    mem_rd_data <= 32'h12345678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LH - word aligned address. Positive immediate value LSB halfword
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0x00000004;        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b001;
    funct3_dec  <= 8'h0x02;
    en          <=1;
    reg_rd_data <= 32'h0xC6C43210;
    
    #10;
    
    mem_rd_data <= 32'hD2D45678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LH - half word aligned address. MSB half word
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0x00000002;        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b001;
    funct3_dec  <= 8'h0x02;
    en          <=1;
    reg_rd_data <= 32'h0xA6A43210;
    
    #10;
    
    mem_rd_data <= 32'hF2F45678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LHU - word aligned address. Positive immediate value LSB halfword
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0x00000004;        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b101;
    funct3_dec  <= 8'h0x20;
    en          <=1;
    reg_rd_data <= 32'h0xE6E43210;
    
    #10;
    
    mem_rd_data <= 32'h92945678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LHU - half word aligned address. MSB half word
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0x00000002;        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b101;
    funct3_dec  <= 8'h0x20;
    en          <=1;
    reg_rd_data <= 32'h0xB6543210;
    
    #10;
    
    mem_rd_data <= 32'hC2345678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LB - word aligned address. 0th byte 
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0x00000004;        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b000;
    funct3_dec  <= 8'h0x01;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    
    #10;
    
    mem_rd_data <= 32'h12345678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LB - word aligned address. 1th byte 
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0xfffffffd;        //-3        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b000;
    funct3_dec  <= 8'h0x01;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    
    #10;
    
    mem_rd_data <= 32'h12A45678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LB - word aligned address. 2nd byte 
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0xfffffffe;    //-2        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b000;
    funct3_dec  <= 8'h0x01;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    
    #10;
    
    mem_rd_data <= 32'h12345678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    
    //LB - word aligned address. 3rd byte 
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0x00000007;        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b000;
    funct3_dec  <= 8'h0x01;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    
    #10;
    
    mem_rd_data <= 32'h12345678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    //$stop;
    /************/
    //LB - word aligned address. 1th byte 
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0xfffffffd;        //-3        
    opcode_dec <=32'h0x00000001;
    funct3      <= 3'b100;
    funct3_dec  <= 8'h0x10;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    
    #10;
    
    mem_rd_data <= 32'h12345678;
    
    #10;
    
    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    
    /*******************/
    //SW - word aligned address. 1th byte 
    operand_0 <= 32'h0x00000008;
    operand_1 <= 32'h0xfffffffd;        //-3        
    opcode_dec <=32'h0x00000100;
    funct3      <= 3'b010;
    funct3_dec  <= 8'h0x04;
    en          <=1;
    reg_rd_data <= 32'h0x76543210;
    #10;
    
    mem_rd_data <= 32'h12345678;
    mem_store_valid <=1;

    #10;
    mem_store_valid <=0;

    if (LSU_done == 1)
        en<= 0;
    else
        en <= 1;    
    #10;
    $finish;

end

endmodule
