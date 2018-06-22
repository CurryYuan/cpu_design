`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 22:10:09
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


module test();
    reg clk,reset;
    
    main uut(.clk(clk),.reset(reset));
    
    initial begin
        clk=0;
        reset=0;
        clk=~clk;
        
        #3;
        reset=1;
        forever #3 clk=~clk;
        
    end
    

    
endmodule
