`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/16 17:54:01
// Design Name: 
// Module Name: clk_div
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

module clk_div #(parameter N = 99_999999)(
    input mclk,
    input button,
    input reset,
    output clk190,
    output reg clkCPU
    );
    
    reg [26:0]q;
    reg [1:0] counter;
    
    initial begin
        q=0;
    end
    
    always@(posedge mclk)
    begin
        q <= q + 1;
        
        if(reset == 0)
            clkCPU = 1; //reset=0是可以提供一个下降沿进行第一条指令的运算
        else
        begin
            if(button == 1)
            begin
                clkCPU <= 1;//按键提供CPU时钟上升沿
                counter <= 0;
            end
            else
            begin
                counter <= counter + 1;
                if(counter == 3)
                    clkCPU <= 0; //CPU时钟下降沿
            end
        end
    end
    
    assign clk190 = q[10]; 
       
endmodule