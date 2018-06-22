`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 10:05:55
// Design Name: 
// Module Name: DataSelect
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


module DataSelect_2(input [31:0] A, B,  
                    input Sign,  
                    output wire [31:0] Get);  
  
    assign Get = Sign ? B : A;  
  
endmodule 
