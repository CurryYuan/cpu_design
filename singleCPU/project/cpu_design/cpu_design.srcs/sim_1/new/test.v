`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/17 19:14:50
// Design Name: 
// Module Name: test
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


module test;
    reg clk,reset;
    
    main uut(.clk(clk),.reset(reset));
    
    initial begin
        clk=1;
        reset=1;

        forever #50 begin
            clk=!clk;
        end
    end
endmodule
