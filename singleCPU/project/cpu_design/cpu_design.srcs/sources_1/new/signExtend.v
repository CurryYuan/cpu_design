`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 22:30:35
// Design Name: 
// Module Name: signExtend
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


module signExtend(
    input wire [15:0] in_num,
    input wire extSel,
    output reg [31:0] out_num
    );
    initial begin
        out_num=0;
    end
    always @(in_num or extSel) begin
        if (extSel) begin
            out_num <= { {16{in_num[15]}}, in_num[15:0] };
        end
        else begin
            out_num <= { {16{1'b0}}, in_num[15:0] };
        end
    end

endmodule
