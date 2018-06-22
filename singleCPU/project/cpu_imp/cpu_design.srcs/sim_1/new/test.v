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
    reg clk,reset,sw1,sw2,sw3;
    
    main uut(.b_clk(clk),.reset(reset),.sw1(sw1),.sw2(sw2),.sw3(sw3));
    
    initial begin
        clk=1;
        reset=0;
        sw1=0;
        sw2=0;
        sw3=0;       
        #1.5 reset=1;
     end       
        always begin
        #5 clk=!clk;
        end
        always begin
        #33 sw1=!sw1;
        end
endmodule
