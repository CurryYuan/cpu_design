`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 22:26:29
// Design Name: 
// Module Name: dataSelect
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


module dataSelect_5_Bit(
    input [4:0] A,
    input [4:0] B,
    input Ctrl,
    output [4:0] S
    );
    assign S = ( Ctrl == 1'b0 ? A : B);
endmodule

module dataSelect_32_Bit(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [1:0] Ctrl,
    output reg [31:0] S
    );
    always @(Ctrl or A or B or C) begin
        case(Ctrl)
         2'b00: S=A;
         2'b01: S=B;
         2'b10: S=C;
        endcase
    end
endmodule

module dataSelect_32_Bit2(A, B, Ctrl, S);
    input [31:0] A, B; 
    input Ctrl; 
    output [31:0] S;
    assign S = (Ctrl == 1'b0 ? A : B);
endmodule

module dataSelect_32_BitA(A, B, Ctrl, S);
    input [31:0] A;
    input [4:0] B;
    input Ctrl; 
    output reg [31:0] S;
    always @(Ctrl or A or B) begin
        if(Ctrl==1'b1) begin
            S <= { {27{1'b0}}, B[4:0] };
        end
        else begin
            S <= A;
        end
    end
endmodule