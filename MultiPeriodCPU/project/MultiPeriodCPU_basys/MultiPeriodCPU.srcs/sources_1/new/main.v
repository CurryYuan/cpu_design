`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 10:31:35
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


module main(input mclk, reset,button,
            input [1:0] switch, 
            output [3:0] pos,
            output [7:0] a_to_g
    );
    
    //数据通路  
    wire [2:0] state_out;
    wire [5:0] opcode;
    wire [4:0] rs, rt, rd;
    wire [31:0] ins, ReadData1, ReadData2, pc0, result;
    wire [31:0] j_addr, out1, out2, result1, extendData, LateOut1, LateOut2, DataOut;  
    wire zero,sign,clk; 
          
    // 控制信号  
    wire [2:0] ALUOp;  
    wire [1:0] ExtSel, RegDst, PCSrc;  
    wire PCWre, IRWre, InsMemRW, WrRegDSrc, RegWre, ALUSrcA, ALUSrcB, mWR, mRD, DBDataSrc; 
    
    assign opcode = ins[31:26];  
    assign rs = ins[25:21];  
    assign rt = ins[20:16];  
    assign rd = ins[15:11]; 
    
    clk_div clk_div(mclk,button,reset,clk190,clk);
    LED LED(clk190,switch,pc0,state_out,rs,ReadData1,rt,ReadData2,result,LateOut2,pos,a_to_g);
 
    PC pc(clk, reset, PCWre, PCSrc, extendData, j_addr, ReadData1, pc0);  
 
    PCAddr pcaddr(ins[25:0], pc0, j_addr);  

    InsMemory insmemory(pc0, InsMemRW, IRWre, clk, ins);  
     
    RegFile regfile(ins[25:21], ins[20:16], ins[15:11], clk, RegWre, WrRegDSrc, RegDst, (pc0+4), LateOut2, ReadData1, ReadData2);  
     
    DataLate ADR(ReadData1, clk, out1);  
    DataLate BDR(ReadData2, clk, out2);  
     
    Extend extend(ins[15:0], ExtSel, extendData);  
      
    ALU alu(out1, out2, extendData, ALUSrcA, ALUSrcB, ALUOp, zero, sign, result);  
      
    DataLate ALUout(result, clk, result1);  
      
    DataMemory datamemory(clk,result1, out2, mRD, mWR, DataOut);  
      
    DataSelect_2 dataselect_2(result, DataOut, DBDataSrc, LateOut1);  
     
    DataLate ALUM2DR(LateOut1, clk, LateOut2);  
      
    controlUnit control(ins[31:26], zero, sign, clk, reset,PCWre, InsMemRW, IRWre, WrRegDSrc, RegWre, ALUSrcA, ALUSrcB, DBDataSrc, mRD, mWR, ExtSel, RegDst, PCSrc, ALUOp, state_out);      

endmodule
