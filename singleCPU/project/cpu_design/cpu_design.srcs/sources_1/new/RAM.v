`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/15 22:14:51
// Design Name: 
// Module Name: RAM
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


module RAM(
	 input clk,
	 input [31:0] address,
	 input [31:0] writeData, // [31:24], [23:16], [15:8], [7:0]
	 input nRD,              // 为0，正常读；为1,输出高组态
	 input nWR,              // 为0，写；为1，无操作
	 output [31:0] Dataout
     );

	 
	 reg [7:0] RAM [0:60]; //存储器
	 
	// 读
     assign Dataout[7:0]   = (nRD==1)?RAM[address + 3]:8'bz; // z 为高阻态
     assign Dataout[15:8]  = (nRD==1)?RAM[address + 2]:8'bz;
     assign Dataout[23:16] = (nRD==1)?RAM[address + 1]:8'bz;
     assign Dataout[31:24] = (nRD==1)?RAM[address ]:8'bz;

    // 写
	 always@( negedge clk ) begin  
		if( nWR ) begin	
		    RAM[address]   <= writeData[31:24];
		    RAM[address+1] <= writeData[23:16];
			RAM[address+2] <= writeData[15:8];
			RAM[address+3] <= writeData[7:0];
		end
	 end
endmodule
