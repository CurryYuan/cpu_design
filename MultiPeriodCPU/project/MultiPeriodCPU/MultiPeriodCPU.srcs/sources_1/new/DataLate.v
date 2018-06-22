`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 10:06:49
// Design Name: 
// Module Name: DataLate
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

module DataLate(input [31:0] i_data,  
                input clk,  
                output reg [31:0] o_data);  
  
    always @(negedge clk) begin  
        o_data = i_data;  
    end  
  
endmodule
