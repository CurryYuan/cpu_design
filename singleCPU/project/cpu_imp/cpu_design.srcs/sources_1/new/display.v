`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 10:19:30
// Design Name: 
// Module Name: display
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


/*module display(
    input clk,reset,sw1,sw2,sw3,
    output [7:0] led,
    output [3:0] sign
    );
    wire clk2;
    wire clk1;
    wire [31:0] out_pc,in_pc,readData1,readData2,WriteData,result;
    wire [4:0] rs,rt;
    wire [3:0] dis0;
    wire [7:0] s1,s0;
    
    clock_div clock_div(clk,sw1,clk1,clk2);
    //main main(.clk(sw1),.reset(reset),.out_pc(out_pc),.in_pc(in_pc),.A(readData1),.B(readData2),.rs(rs),.rt(rt),.WriteData(WriteData),.result(result));
    main main(sw1,reset,out_pc,in_pc,readData1,readData2,rs,rt,WriteData,result);
    counter counter(clk1,reset,sign);
    fourSelectOne1 fourSelectOne1(out_pc,result,rs,rt,sw2,sw3,s1);
    fourSelectOne2 fourSelectOne2(in_pc,readData1,readData2,WriteData,sw2,sw3,s0);
    fourSelectOne fourSelectOne(s1[7:4],s1[3:0],s0[7:4],s0[3:0],sign,dis0);
    
    SegLED SegLED(dis0,led);
    
    
    
endmodule*/
