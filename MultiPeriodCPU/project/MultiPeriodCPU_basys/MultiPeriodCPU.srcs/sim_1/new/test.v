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
    reg mclk, Reset, button;
    reg [1:0] switch;
    wire [3:0] pos;
    wire [6:0] a_to_g;
    
    main main(mclk,Reset,button,switch,pos,a_to_g);
    
    initial begin
       Reset=0;
       mclk=0;
       button = 0;
       
     
       #1.5
       Reset = 1;
       switch = 2'b00;
       end
       
       always begin
       #2 mclk = ~mclk;
       end
       
       always begin
       #15 button = ~button;
        
    end
    

    
endmodule
