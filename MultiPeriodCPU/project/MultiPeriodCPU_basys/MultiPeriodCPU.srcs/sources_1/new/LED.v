`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/16 17:41:27
// Design Name: 
// Module Name: LED
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


module LED(
    input clk190,
    input [1:0] switch,
    input [31:0] address,
    input [2:0] state_out,
    input [4:0] rs,
    input [31:0] ReadData1,
    input [4:0] rt,
    input [31:0] ReadData2,
    input [31:0] result,
    input [31:0] WriteData,
    output reg [3:0] pos,
    output reg [7:0] seg
    );
    reg [1:0] counter = 2'b00;    
    //reg [6:0] pos_;
    
    // assign pos = pos_;
    reg [3:0] number;

    always@(posedge clk190)
    begin
        counter <= counter + 1;
    
        //三号数码管(AN3)显示
        if(counter == 0)
        begin
            case (switch)
                2'b00:number <= address[7:4];
                2'b01:number = {3'b000, rs[4]};
                2'b10:number = {3'b000, rt[4]};
                2'b11:number = result[7:4];
            endcase
            
            pos <= 4'b0111;
        end
    
        //二号数码管(AN2)显示    
        else if(counter == 1)
        begin
            case (switch)
                2'b00:number <= address[3:0];
                2'b01:number = rs[3:0];
                2'b10:number = rt[3:0];
                2'b11:number = result[3:0];
            endcase
           
            pos <= 4'b1011;              
        end
    
    //一号数码管(AN1)显示    
    else if(counter == 2)
    begin
        case (switch)
            2'b00:number <= 4'b0000;
            2'b01:number = ReadData1[7:4];
            2'b10:number = ReadData2[7:4];
            2'b11:number = WriteData[7:4];
        endcase
        
        pos <= 4'b1101;             
    end      
    
    //零号数码管(AN0)显示    
    else if(counter ==3)
    begin
        
        case (switch)
            2'b00:number <= {1'b0, state_out[2:0]};
            2'b01:number = ReadData1[3:0];
            2'b10:number = ReadData2[3:0];
            2'b11:number = WriteData[3:0];
        endcase
       
        pos <= 4'b1110;              
    end 
end    
    always@ (number) begin
      case(number)
        4'b0000 : seg = 8'b1100_0000; //0；'0'-亮灯，'1'-熄灯
        4'b0001 : seg = 8'b1111_1001; //1
        4'b0010 : seg = 8'b1010_0100; //2
        4'b0011 : seg = 8'b1011_0000; //3
        4'b0100 : seg = 8'b1001_1001; //4
        4'b0101 : seg = 8'b1001_0010; //5
        4'b0110 : seg = 8'b1000_0010; //6
        4'b0111 : seg = 8'b1101_1000; //7
        4'b1000 : seg = 8'b1000_0000; //8
        4'b1001 : seg = 8'b1001_0000; //9
        4'b1010 : seg = 8'b1000_1000; //A
        4'b1011 : seg = 8'b1000_0011; //b
        4'b1100 : seg = 8'b1100_0110; //C
        4'b1101 : seg = 8'b1010_0001; //d
        4'b1110 : seg = 8'b1000_0110; //E
        4'b1111 : seg = 8'b1000_1110; //F
        default : seg = 8'b0000_0000; //不亮
      endcase 
    end
endmodule
