`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 16:55:00
// Design Name: 
// Module Name: CU
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


module CU(
    input [5:0] decode,
    input zero,
    output reg pcWire,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg DBDataSrc,
    output reg RegWire,
    output reg InsMemRW,
    output reg nRD,
    output reg nWR,
    output reg RegDst,
    output reg ExtSel,
    output reg [1:0] pcSrc,
    output reg [2:0] ALUOp
    );
    
    initial begin
        pcWire=1;
        ALUSrcA=1;
        ALUSrcB=1;
        DBDataSrc=1;
        InsMemRW=1;
        nRD=0;
        nWR=0;
    end
    
    always@(decode or zero) begin
        case(decode)
         6'b000000:              //add
         begin
            ALUSrcA=0;
            ALUSrcB=0;
            DBDataSrc=0;
            RegWire=1;
            RegDst=1;
            ExtSel=1;
            pcSrc=2'b00;
            ALUOp=3'b000;
         end
         6'b000001:              //addi                   
         begin
            ALUSrcA=0;
            ALUSrcB=1;
            DBDataSrc=0;
            RegWire=1;
            RegDst=0;
            ExtSel=1;
            pcSrc=2'b00;
            ALUOp=3'b000;        
         end
         6'b000010:              //sub 
         begin
            ALUSrcA=0;
            ALUSrcB=0;
            DBDataSrc=0;
            RegWire=1;
            RegDst=1;
            ExtSel=1;
            pcSrc=2'b00;
            ALUOp=3'b001;
         end
         6'b010000:              //ori
         begin
            ALUSrcA=0;
            ALUSrcB=1;
            DBDataSrc=0;
            RegWire=1;
            RegDst=0;
            ExtSel=0;
            pcSrc=2'b00;
            ALUOp=3'b011;
         end
         6'b010001:              //and
         begin
            ALUSrcA=0;
            ALUSrcB=0;
            DBDataSrc=0;
            RegWire=1;
            RegDst=1;
            pcSrc=2'b00;
            ALUOp=3'b100;
         end
         6'b010010:              //or
         begin
            ALUSrcA=0;
            ALUSrcB=0;
            DBDataSrc=0;
            RegWire=1;
            RegDst=1;
            pcSrc=2'b00;
            ALUOp=3'b011;
         end
         6'b011000:              //sll
         begin
            ALUSrcA=1;
            ALUSrcB=0;
            DBDataSrc=0;
            RegWire=1;
            RegDst=1;
            ExtSel=0;
            pcSrc=2'b00;
            ALUOp=3'b010;
         end
         6'b011011:              //slti
         begin
            ALUSrcA=0;
            ALUSrcB=1;
            RegWire=1;
            RegDst=0;
            ExtSel=1;
            pcSrc=2'b00;
            ALUOp=3'b110;
         end
         6'b100110:              //sw
         begin
            ALUSrcA=0;
            ALUSrcB=1;
            DBDataSrc=0;
            RegWire=0;
            nWR=1;
            nRD=0;
            ExtSel=1;
            pcSrc=2'b00;
            ALUOp=3'b000;
         end
         6'b100111:              //lw
         begin
            ALUSrcA=0;
            ALUSrcB=1;
            DBDataSrc=1;
            RegWire=1;
            nRD=1;
            nWR=0;
            RegDst=0;
            ExtSel=1;
            pcSrc=2'b00;
            ALUOp=3'b000;
         end
         6'b110000:              //beq
         begin
            ALUSrcA=0;
            ALUSrcB=0;
            RegWire=0;
            ExtSel=1;
            if (zero)
                pcSrc=2'b01;
            else
                pcSrc=2'b00;
            ALUOp=3'b001;
         end
         6'b110001:              //bne
         begin
            ALUSrcA=0;
            ALUSrcB=0;
            RegWire=0;
            ExtSel=1;
            if (zero)
                pcSrc=2'b00;
            else
                pcSrc=2'b01;
            ALUOp=3'b001;
         end
         6'b111000:              //j
         begin
            RegWire=0;
            pcSrc=10;
         end
         6'b111111:              //halt
         begin
            pcWire=0;
         end
        endcase
    end
endmodule
