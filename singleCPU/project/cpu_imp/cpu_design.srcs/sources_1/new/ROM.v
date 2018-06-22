`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 16:38:17
// Design Name: 
// Module Name: ROM
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


module ROM(
    input rd,                   // 为1，读
    input [31:0] addr,
    output reg [31:0] dataOut
    );

     reg [7:0] mem [0:99];   // mem 存储器，100个内存单元，存储单位为8位长度，一字节长度
     
     initial
         $readmemb ("D:/vivado/cpu_imp/rom_data.txt", mem);  //绝对地址。可将rom_data.coe或rom_data.txt数据文件数据，加载到ROM
         
     always @( addr or rd)
         if (rd)begin
             dataOut[7:0] = mem[addr + 3];
             dataOut[15:8] = mem[addr + 2];
             dataOut[23:16] = mem[addr + 1];
             dataOut[31:24] = mem[addr];
         end             
endmodule
