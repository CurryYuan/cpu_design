`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 11:15:05
// Design Name: 
// Module Name: clock_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:b
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_div(
    input clk, //100MHz��ϵͳĬ����Ƶ��,
    input sw1,
    output reg clk_sys = 0, //1Hz����Ƶ���Ƶ�ʡ������ʼ��Ϊ0,
    output reg clk2
);

    reg [25:0] div_counter = 0;
    always @(posedge clk) begin
    //if(div_counter>=1) begin // ���ڷ���
    if(div_counter>=10000) begin // �������ɱ������ļ�������
        clk_sys <= ~clk_sys; // ��ƽ����
        div_counter <= 0;
    end else begin
        div_counter <= div_counter + 1;
        end
    end
    reg [1:0] counter = 0;
    always @( posedge clk) begin
        if(sw1 == 1) begin
            clk2 = 1;//�����ṩCPUʱ��������
            counter = 0;
        end
        else begin
            counter = counter + 1;
            if(counter == 3)
                clk2 = 0; //CPUʱ���½���
        end
    end
    
endmodule
