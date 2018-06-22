`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 11:16:02
// Design Name: 
// Module Name: counter
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


module counter(
    input clk,
    output reg [3:0] sign
    );
    reg [1:0] count;
    initial count=3;
    always @(posedge clk) begin
            if(count == 2'b0)
                count = 3;
            else begin
                count = count - 1; // ¼õ1 ¼ÆÊý
            end

    end
    always @(count) begin
        case (count) 
            2'b00: sign=4'b1110;
            2'b01: sign=4'b1101;
            2'b10: sign=4'b1011;
            2'b11: sign=4'b0111;
        endcase
    end
endmodule
