`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 09:55:00
// Design Name: 
// Module Name: InsMemory
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

module InsMemory(input [31:0] addr,  
                 input InsMemRW, IRWre, clk,  
                      output reg [31:0] ins);  
                        
     reg [31:0] ins_out;  
     reg [7:0] mem [0:127];  
       
     initial begin  
         $readmemb("D:/vivado/MultiPeriodCPU/store.txt", mem);  
          //ins_out = 0;  
     end  
  
     always @( addr or InsMemRW) begin  
        if (InsMemRW) begin  
          ins_out[31:24] = mem[addr];  
          ins_out[23:16] = mem[addr+1];  
          ins_out[15:8] = mem[addr+2];  
          ins_out[7:0] = mem[addr+3];  
        end  
     end  
       
     always @(posedge clk) begin  
         if (IRWre) ins <= ins_out;  
     end  
  
endmodule 
