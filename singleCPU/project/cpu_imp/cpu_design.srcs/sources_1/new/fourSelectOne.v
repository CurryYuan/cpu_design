`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 11:00:45
// Design Name: 
// Module Name: fourSelectOne
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


module fourSelectOne(
    input [3:0] s0,s1,s2,s3,sign,
    output reg [3:0] out
    );
    always @(sign or s1 or s2 or s3) begin
        case (sign) 
            4'b1110: out = s3;
            4'b1101: out = s2;
            4'b1011: out = s1;
            4'b0111: out = s0;
        endcase
    end
endmodule

module fourSelectOne1(
    input clk,
    input [31:0] pc,res,
    input [4:0] rs,rt,
    input sw2,sw3,
    output reg [7:0] out
    );
    initial out = 8'b0;
    always @(sw2 or sw3) begin
        if(!sw2&&!sw3) begin
            out = pc[7:0];
        end
        if (sw2&&!sw3) begin
            out = { {3{1'b0}}, rs[4:0]};
        end 
        if (!sw2&&sw3) begin
            out = { {3{1'b0}}, rt[4:0]};
        end 
        if (sw2&&sw3) begin
            out = res[7:0];
        end
    end
endmodule

module fourSelectOne2(
    input clk,
    input [31:0] pc,rs,rt,db,
    input sw2,sw3,
    output reg [7:0] out
    );
    initial out = 8'b0;
    always @(sw2 or sw3) begin
        if(!sw2&&!sw3) begin
            out = pc[7:0];
        end 
        if (sw2&&!sw3) begin
            out = rs[7:0];
        end
        if (!sw2&&sw3) begin
            out = rt[7:0];
        end
        if (sw2&&sw3) begin
            out = db[7:0];
        end
    end
endmodule
