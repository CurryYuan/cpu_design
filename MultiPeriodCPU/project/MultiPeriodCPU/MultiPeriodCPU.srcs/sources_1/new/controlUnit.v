`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 10:08:59
// Design Name: 
// Module Name: controlUnit
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

module controlUnit(input [5:0] opcode,   
                   input zero, sign, clk, Reset,  
           output reg PCWre, InsMemRW, IRWre, WrRegDSrc, RegWre, ALUSrcA, ALUSrcB, DBDataSrc, mRD, mWR,  
           output reg [1:0] ExtSel, RegDst, PCSrc,  
           output reg [2:0] ALUOp, state_out);  
    parameter [2:0] sif = 3'b000,   // IF state  
                    sid = 3'b001,   // ID state  
                    exe = 3'b010,   // EXE state
                    smem = 3'b100,  // MEM state  
                    swb = 3'b011;   // WB state
                            
    parameter [5:0] addi = 6'b000010,  
                    ori = 6'b010010,  
                    sll = 6'b011000,  
                    add = 6'b000000,  
                    sub = 6'b000001,  
                    slt = 6'b100110,
                    sltiu = 6'b100111,  
                    sw = 6'b110000,  
                    lw = 6'b110001,  
                    beq = 6'b110100,
                    bltz = 6'b110110,  
                    j = 6'b111000,  
                    jr = 6'b111001,  
                    Or = 6'b010000,  
                    And = 6'b010001,  
                    jal = 6'b111010,  
                    halt = 6'b111111;  
                                   
    reg [2:0] state, next_state;  
      
    initial begin  
        PCWre = 0;  
        InsMemRW = 0;  
        IRWre = 0;  
        WrRegDSrc = 0;  
        RegWre = 0;
        ALUSrcA = 0;  
        ALUSrcB = 0;  
        DBDataSrc = 0;  
        mRD = 0;  
        mWR = 0;
        ExtSel = 2'b11;  
        RegDst = 2'b11;  
        PCSrc = 2'b00;  
        ALUOp = 0;  
        state = sif;  
        state_out = state;  
    end  
      
    always @(posedge clk) begin  
         if (Reset == 0) begin  
              state <= sif;  
         end else begin  
              state <= next_state;  
         end  
         state_out = state;  
    end  
      
    always @(state or opcode) begin  
    case(state)  
         sif: next_state = sid;  
         sid: begin  
             case (opcode[5:3])  
                3'b111: next_state = sif; // j, jal, jr, halt等指令   
                default: next_state = exe; // else 
             endcase  
         end  
         exe: begin
             case (opcode)
                6'b110100: next_state = sif;    //beq
                6'b110110: next_state = sif;    //bltz
                6'b110000: next_state = smem;   //sw
                6'b110001: next_state = smem;   //lw
                default: next_state = swb;      //else
             endcase
         end
         smem: begin  
             if (opcode == 6'b110001) next_state = swb; // lw指令  
                else next_state = sif; // sw指令  
         end   
         default: next_state = sif;  
         endcase  
    end  
           
    always @(state or opcode) begin  
      
        // 确定PCWre的值  
        if (state == sif && opcode != halt) PCWre = 1;  
        else PCWre = 0;  
            
        // 确定InsMemRW的值  
        InsMemRW = 1;  
            
        // 确定IRWre的值  
        if (state == sif) IRWre = 1;  
        else IRWre = 0;  
            
        // 确定WrRegDSrc的值  
        if (state == swb) WrRegDSrc = 1;  
        else WrRegDSrc = 0;  
            
        // 确定RegWre的值  
        if (state == swb || opcode == jal) RegWre = 1;  
        else RegWre = 0;  
        
        // ALUSrcA
        if (opcode ==sll) ALUSrcA = 1;
        else ALUSrcA = 0;
          
          // 确定ALUSrcB的值  
        if (opcode == addi || opcode == ori || opcode == sltiu || opcode == sw || opcode == lw) ALUSrcB = 1;  
        else ALUSrcB = 0;  
          
          // mWR, mRD
        if (state == smem) begin
            if(opcode == sw) begin
                mWR = 1;
                mRD = 0;
            end else begin
                mWR = 0;
                mRD = 1;
            end
        end else begin
            mWR = 0;
            mRD = 0;
        end        
          
          // 确定DBDataSrc的值  
        if (state == swb && opcode == lw ) DBDataSrc = 1;  
        else DBDataSrc = 0;  
          
          // 确定ExtSel的值  
        if (opcode == ori || opcode == sltiu) ExtSel = 2'b01;  
        else if (opcode == sll) ExtSel = 2'b00;  
        else ExtSel = 2'b10;  
          
          // 确定RegDst的值  
        if (opcode == jal) RegDst = 2'b00;  
        else if (opcode == addi || opcode == ori || opcode == sltiu || opcode == lw) RegDst = 2'b01;  
        else RegDst = 2'b10;  
          
          // 确定PCSrc的值  
        case(opcode)  
            j: PCSrc = 2'b11;  
            jal: PCSrc = 2'b11;  
            jr: PCSrc = 2'b10;  
            beq: begin  
                if (zero) PCSrc = 2'b01;  
                else PCSrc = 2'b00;  
            end  
            bltz: begin
                if(sign==1&&zero==0) PCSrc = 2'b01;
                else PCSrc = 2'b00;
            end
            default: PCSrc = 2'b00;  
        endcase  
          
          // 确定ALUOp的值  
        case(opcode)  
            sub: ALUOp = 3'b001;  
            Or: ALUOp = 3'b101;  
            And: ALUOp = 3'b110;  
            ori: ALUOp = 3'b101;  
            sltiu: ALUOp = 3'b010;  
            slt: ALUOp = 3'b011;
            sll: ALUOp = 3'b100;  
            beq: ALUOp = 3'b001;  
            bltz: ALUOp = 3'b001;
            default: ALUOp = 3'b000;  
        endcase  
          
          // 防止在IF阶段写数据  
        if (state == sif) begin  
            RegWre = 0;  
        end  
    end  
           
endmodule  
