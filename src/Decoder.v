`include "header.vh"

module Decoder(
    input wire [31:0] inst,
    output wire [4:0] rs1, rs2, rd,
    output reg [3:0] ALU_sel, WEN,
    output wire [2:0] BC_sel, LD_sel,
    output wire ALU_IMM_sel, ALU_PC_sel, RD_PC_sel,
    output wire signed [31:0] immediate,
    output wire LUI, AUIPC, JAL, JALR, BR, LD, ST, IMM, ALU, FENCE, HALT_d
   
);
    wire [6:0] OP_MSB;
    wire [2:0] funct3;
    wire [6:0] funct7;
            
immediateExtender ImmExt(.instruction(inst),.imm(immediate));   //Immediate extender module

    assign OP_MSB = inst[6:0];
    assign funct3 = inst[14:12];
    assign funct7 = inst[31:25];
    
    assign LUI = OP_MSB == `LUI;
    assign AUIPC = OP_MSB == `AUIPC;
    assign JAL = OP_MSB == `JAL;
    assign JALR = OP_MSB == `JALR;
    assign BR = OP_MSB == `BR;
    assign LD = OP_MSB == `LD;
    assign ST = OP_MSB == `ST;
    assign IMM = OP_MSB == `IMM;
    assign ALU = OP_MSB == `ALU;
    assign FENCE = OP_MSB == `FENCE;
    assign HALT_d = OP_MSB == `SYSTEM;
    
    assign rs1 = (LUI || FENCE) ? 5'b00000 : inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = FENCE ? 5'b00000 : inst[11:7];
    
    assign BC_sel = funct3;
    assign LD_sel = funct3;
    assign ALU_IMM_sel = LD || ST || IMM || BR || JALR || JAL || LUI || AUIPC;
    assign ALU_PC_sel = JAL || AUIPC || BR;
    assign RD_PC_sel = JAL || JALR;
    
    always@(*) begin
    
      //DMEM READ/WRITE ENABLE
        case(funct3)
               `SB : WEN = 4'b0001; 
               `SH : WEN = 4'b0011;
               `SW : WEN = 4'b1111;
            default: WEN = 4'b0000;
        endcase
        
      //COMPUTE ALU OPERATION
        case( LD || ST || BR || JALR || JAL || LUI || AUIPC || FENCE )
            1'b1 : ALU_sel = `ADD;
            default: ALU_sel = {(funct7[5] && ((funct3[0] && ~funct3[1]) || ~IMM)),funct3};
                                   //pick funct7[5] ONLY when not IMM type OR SHIFT inst           
        endcase
        
    end
        
endmodule
