`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 09:31:03
// Design Name: 
// Module Name: PC
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


module PC(input clk, Reset, PCWre,  
          input [1:0] PCSrc,  
          input wire [31:0] imm, addr, RDout1,  
          output reg [31:0] Address);  
               
     always @(posedge clk) begin // 这里和单周期不太一样，存在延迟的问题，只有当pcWre改变的时候或者Reset改变的时候再检测  
        if (Reset == 0) begin  
            Address = 0;  
        end else if (PCWre) begin  
            if (PCSrc == 2'b00) begin  
                    Address = Address+4;  
                end else if (PCSrc == 2'b01) begin  
                    Address = imm*4+Address+4;  
                end else if (PCSrc == 2'b10) begin  
                    Address = RDout1;  
                end else if (PCSrc == 2'b11) begin  
                    Address = addr;  
                end  
        end 
    end  
  
endmodule 

module PCAddr(input [25:0] in_addr,  
              input [31:0] PC0,  
                  output reg [31:0] addr);  
    wire [27:0] mid;  
     assign mid = in_addr << 2;  
    always @(in_addr or PC0 or mid) begin  
        addr <= {PC0[31:28], mid[27:0]};  
    end  
  
endmodule  
