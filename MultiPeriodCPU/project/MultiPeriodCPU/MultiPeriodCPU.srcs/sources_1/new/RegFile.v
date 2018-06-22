`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 09:58:11
// Design Name: 
// Module Name: RegFile
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

  
module RegFile(input [4:0] rs, rt, rd,  
               input clk, RegWre, WrRegDSrc,  
               input [1:0] RegDst,  
               input [31:0] PC4, memData,  
               output reg [31:0] data1, data2);  
  
    reg [31:0] i_data;  
       
       
    reg [4:0] temp;  
       
    reg [31:0] register [0:31];  
    integer i;  
    initial begin  
        for (i = 0 ; i < 32; i = i+1)   
              register[i] = 0;  
    end  
      
    always @(negedge clk) begin  
        case(RegDst)  
             2'b00: temp = 5'b11111;  
             2'b01: temp = rt;  
             2'b10: temp = rd;  
             default temp = 0;  
        endcase  
        assign i_data = WrRegDSrc? memData : PC4;  
        assign data1 = register[rs];  
        assign data2 = register[rt];  
        if ((temp != 0) && (RegWre == 1)) begin // temp != 0 确保零号寄存器不会改变  
            register[temp] <= i_data;  
        end  
    end  
  
endmodule 