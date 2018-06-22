`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 11:01:09
// Design Name: 
// Module Name: pc
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


module pc(clk, reset, in_pc, out_pc, pcWire);
    input wire clk,reset,pcWire;
    input wire [31:0] in_pc;
    output reg [31:0] out_pc;
    
    initial begin
        out_pc=0;
    end
    
    always @(posedge clk) begin
        if (!reset) begin
            out_pc=0;
        end else if (pcWire) begin
            out_pc=in_pc;
        end else if (!pcWire) begin
            out_pc=out_pc;
        end
    end
endmodule

module pcAddFour(in_pc, out_pc);
    input wire [31:0] in_pc;
    output wire [31:0] out_pc;    
    assign out_pc[31:0] = in_pc[31:0] + 4;
endmodule

module pcAddImm(
    input [31:0] now_pc,
    input [31:0] addNum,
    output wire [31:0] out_pc
    );
    assign out_pc = now_pc + (addNum * 4);    //×óÒÆÁ½Î»
endmodule

module pcJump(
    input wire [31:0] pc4,
    input wire [31:0] addr,
    output reg [31:0] out
    );
    always @(pc4 or addr) begin
        out <= { pc4[31:28],addr[27:2],{2{1'b0}} };
    end
endmodule
