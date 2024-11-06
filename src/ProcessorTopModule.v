`include "header.vh"

module ProcessorTopModule(
    input wire CLK, BTN,
    input wire [15:0] SWITCH,
    output wire [15:0] LED,
    output wire [7:0] SEG,
    output wire [3:0] AN
    );

wire [4:0] RS1_ADDR, RS2_ADDR, RD_ADDR;
wire [3:0] ALU_SEL;
wire [2:0] BR_SEL, LD_SEL;
wire [31:0] INST_ADDR;
wire [31:0] INST;
wire ALU_IMM_SEL, ALU_PC_SEL, RD_PC_SEL;
wire PC_WEN, PC_IMM_EN, PC_HALT, BR_OUT, REGF_WEN, DMEM_RDEN, IMEM_RDEN_NHALT, IMEM_RDEN;
wire [3:0] DMEM_WEN, WEN_DMEM_DEC;
wire [31:0] IMM, RS1_DOUT, RS2_DOUT, RD_DIN;
wire [31:0] DMEM_DOUT;
wire [31:0] ALU_IN1, ALU_IN2, ALU_EOUT;
wire AUIPC_CHK, JALR_CHK, LUI_CHK, JAL_CHK, LD_CHK, ST_CHK, IMM_CHK, ALU_CHK, BR_CHK, FENCE_CHK, HALT_CHK;
wire OPHALT_PCHALT_CHK;
wire RST;

assign RST = ~BTN;
assign OPHALT_PCHALT_CHK = HALT_CHK || PC_HALT;
assign SEG = 7'h00;
assign AN = OPHALT_PCHALT_CHK ? 4'hf : 4'h0;

// CONTROL UNTT MODULE
(* keep_hierarchy = "yes" *) CntUnit Control_Unit(.clk(CLK),.rst(RST),.HALT_cnt(OPHALT_PCHALT_CHK),.FE(FENCE_CHK),.LD(LD_CHK),.ST(ST_CHK),.BR(BR_CHK),.WEN_DMEM_DEC(WEN_DMEM_DEC),.WEN_PC(PC_WEN),.WEN_REGF(REGF_WEN),.RDEN_IMEM(IMEM_RDEN),.RDEN_DMEM(DMEM_RDEN),.WEN_DMEM(DMEM_WEN));
assign PC_IMM_EN = JAL_CHK || JALR_CHK || (BR_CHK && BR_OUT);

// PROGRAM COUNTER MODULE
(* keep_hierarchy = "yes" *) PC Program_Counter(.clk(CLK),.rst(RST),.WEN(PC_WEN),.IMM(PC_IMM_EN),.IMM_addr(ALU_EOUT),.inst_addr(INST_ADDR),.HALT_pc(PC_HALT));
assign IMEM_RDEN_NHALT = IMEM_RDEN && ~PC_HALT;

// INSTRUCTION MEMORY MODULE
(* keep_hierarchy = "yes" *) INS_MEM Instruction_Memory(.clk(CLK),.rd(IMEM_RDEN_NHALT),.instr_addr(INST_ADDR),.instr(INST));

// DECODER MODULE
(* keep_hierarchy = "yes" *) Decoder Dec(.inst(INST),.rs1(RS1_ADDR),.rs2(RS2_ADDR),.rd(RD_ADDR),.BC_sel(BR_SEL),.LD_sel(LD_SEL),.ALU_IMM_sel(ALU_IMM_SEL),.ALU_PC_sel(ALU_PC_SEL),.RD_PC_sel(RD_PC_SEL),.immediate(IMM),.JAL(JAL_CHK),.JALR(JALR_CHK),.LD(LD_CHK),.ST(ST_CHK),.LUI(LUI_CHK),.BR(BR_CHK),.AUIPC(AUIPC_CHK),.IMM(IMM_CHK),.ALU(ALU_CHK),.FENCE(FENCE_CHK),.HALT_d(HALT_CHK),.ALU_sel(ALU_SEL),.WEN(WEN_DMEM_DEC));
assign RD_DIN = RD_PC_SEL ? (INST_ADDR + 4) : (LD_CHK ? DMEM_DOUT : ALU_EOUT);

// REGISTER FILE MODULE
(* keep_hierarchy = "yes" *) registerFile Register_File(.clock(CLK),.reset_n(RST),.writeEnable(REGF_WEN),.rs1_address(RS1_ADDR),.rs2_address(RS2_ADDR),.rd_address(RD_ADDR),.rd_dataIn(RD_DIN),.rs1_dataOut(RS1_DOUT),.rs2_dataOut(RS2_DOUT));

// BRANCH COMPARATOR MODULE
(* keep_hierarchy = "yes" *) BranchComparator Branch_Comparator(.opBranch(BR_SEL),.operand1(RS1_DOUT),.operand2(RS2_DOUT),.outBranch(BR_OUT));
assign ALU_IN1 = ALU_PC_SEL ? INST_ADDR : RS1_DOUT;
assign ALU_IN2 = ALU_IMM_SEL? IMM : RS2_DOUT;

// ALU MODULE
(* keep_hierarchy = "yes" *) ALU Arithmetic_Logic_Unit(.opdA(ALU_IN1),.opdB(ALU_IN2),.op_sel(ALU_SEL),.out(ALU_EOUT));

// DATA MEMORY MODULE
(* keep_hierarchy = "yes" *) DMEM Data_Memory(.clk(CLK),.rstn(RST),.rd(DMEM_RDEN),.we(DMEM_WEN),.load_select(LD_SEL),.addr_in(ALU_EOUT),.data_in(RS2_DOUT),.data_out(DMEM_DOUT),.switch(SWITCH),.led(LED));

endmodule
