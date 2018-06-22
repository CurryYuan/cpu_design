`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 10:55:59
// Design Name: 
// Module Name: main
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

module main(
    input wire clk,
    input wire reset
    );
    
    wire [31:0] in_pc,out_pc,out_pc1,out_pc4,out_pcj,out_pci,WriteData,readData1,readData2,extendData,result,DataOut,A,B;
    wire zero,pcWire,ALUSrcA,ALUSrcB,DBDataSrc,RegWire,InsMemRW,nRD,nWR,RegDst,ExtSel;
    wire [1:0] pcSrc;
    wire [2:0] ALUOp;
    wire [4:0] rs,rt,WriteReg;
    
    assign rs=out_pc1[25:21];
    assign rt=out_pc1[20:16];
    
    pc pc(clk, reset, in_pc, out_pc, pcWire);
    ROM ROM(InsMemRW,out_pc,out_pc1);
    CU CU(out_pc1[31:26],zero,pcWire,ALUSrcA,ALUSrcB,DBDataSrc,RegWire,InsMemRW,nRD,nWR,RegDst,ExtSel,pcSrc,ALUOp);
    dataSelect_5_Bit dataSelect_5_Bit(rt,out_pc1[15:11],RegDst,WriteReg);
    RegFile RegFile(clk,reset,RegWire,rs,rt,WriteReg,WriteData,readData1,readData2);
    pcAddFour pcAddFour(out_pc, out_pc4);
    pcAddImm pcAddImm(out_pc4,extendData,out_pci);
    RAM RAM(clk,result,readData2,nRD,nWR,DataOut);
    dataSelect_32_Bit2 dataSelect_32_Bit2(result,DataOut,DBDataSrc,WriteData);
    dataSelect_32_Bit dataSelect_32_Bit(out_pc4,out_pci,out_pcj,pcSrc,in_pc);
    
    dataSelect_32_BitA dataSelect_32_BitA(readData1,out_pc1[10:6],ALUSrcA,A);
    dataSelect_32_Bit2 dataSelect_32_BitB(readData2,extendData,ALUSrcB,B);
    signExtend signExtend(out_pc1[15:0],ExtSel,extendData);
    pcJump pcJump(out_pc4,out_pc1,out_pcj);  
    ALU ALU(ALUOp,A,B,result,zero);
endmodule
