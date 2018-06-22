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
    input b_clk,reset,sw1,sw2,sw3,
    output t,
    output [7:0] led,
    output [3:0] sign
    );
    
    wire clk,clk1;
    wire [31:0] out_pc1,out_pc4,out_pcj,out_pci,readData1,readData2,extendData,DataOut,out_pc,in_pc,WriteData,result,A,B;
    wire zero,pcWire,ALUSrcA,ALUSrcB,DBDataSrc,RegWire,InsMemRW,nRD,nWR,RegDst,ExtSel;
    wire [1:0] pcSrc;
    wire [2:0] ALUOp;
    wire [4:0] WriteReg,rs,rt;
    wire [3:0] dis0;
    wire [7:0] s1,s0;
    
    
    assign rs=out_pc1[25:21];
    assign rt=out_pc1[20:16];
    assign t=clk;
    
    clock_div clock_div(b_clk,sw1,clk1,clk);
    counter counter(clk1,sign);
    fourSelectOne1 fourSelectOne1(clk1,out_pc,result,rs,rt,sw2,sw3,s1);
    fourSelectOne2 fourSelectOne2(clk1,in_pc,A,B,WriteData,sw2,sw3,s0);
    fourSelectOne fourSelectOne(s1[7:4],s1[3:0],s0[7:4],s0[3:0],sign,dis0);
    SegLED SegLED(in_pc[3:0],led);
    
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
