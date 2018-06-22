`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 10:07:32
// Design Name: 
// Module Name: ALU
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


module ALU(input [31:0] ReadData1, ReadData2, inExt,   
           input ALUSrcA,ALUSrcB,  
           input [2:0] ALUOp,  
           output wire zero,
           output wire sign,  
           output reg [31:0] result);  
       
    initial begin  
        result = 0;  
    end  
  
    wire [31:0] A, B;  
    assign A = ALUSrcA? inExt : ReadData1;
    assign B = ALUSrcB? inExt : ReadData2;  
    assign zero = (result? 0 : 1); 
    assign sign = result[31]; 
       
    always @(A or B or ALUOp) begin  
        case(ALUOp)  
            3'b000: result = A + B;  // A + B  
            3'b001: result = A - B;  // A - B  
            3'b010: result = (A < B ? 1 : 0);  // 比较A与B  
            3'b011: result = (((A<B)&&(A[31]==B[31]))||((A[31]==1&&B[31]==0)))?1:0;
            3'b100: result = B << A; // A左移B位  
            3'b101: result = A | B; // 或  
            3'b110: result = A & B; // 与  
            3'b111: result = (~A & B) | (A & ~B); // 异或  
            default: result = 0;  
        endcase  
    end  
       
endmodule