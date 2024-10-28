//ALU
`define ADD    4'b0000
`define SUB    4'b1000 
`define SLL    4'b0001 
`define SLT    4'b0010 
`define SLTU   4'b0011 
`define XOR    4'b0100 
`define SRL    4'b0101
`define SRA    4'b1101 
`define OR     4'b0110 
`define AND    4'b0111

//CntUnit States
`define IF     3'b000
`define IDEX   3'b001
`define MEM    3'b010
`define WB     3'b011
`define HALT   3'b100

//Decoder + Immediate Extender
`define AUIPC  7'b0010111
`define LUI    7'b0110111 
`define BR     7'b1100011 
`define LD     7'b0000011 
`define ST     7'b0100011 
`define IMM    7'b0010011 
`define ALU    7'b0110011   
`define JAL    7'b1101111 
`define JALR   7'b1100111 
`define FENCE  7'b0001111 
`define HALT_d 7'b1110011
`define SB     3'b000 
`define SH     3'b001 
`define SW     3'b010 
`define BRANCH  7'b1100011 
`define LOAD    7'b0000011 
`define STORE   7'b0100011 
`define SYSTEM  7'b1110011

//=======================================================================
// BRANCH COMPARATOR UNIT Instructions Definition:
//=======================================================================
//Equality Check, irrespective of Sign
`define BEQ  3'b000//1. Branch if, Equal  
`define BNE  3'b001//2. Branch if, Inequal

//Signed Section: 
`define BLT  3'b100//3. Branch if, Signed=>Less Than 
`define BGE  3'b101//4. Branch if, Signed=>Greater Than

//Unsigned Section: 
`define BLTU 3'b110//5. Branch if, UnSigned=> Less Than
`define BGEU 3'b111//6. Branch if, UnSigned=> Greater Than


//=======================================================================

// LOAD INSTRUCTIONS
`define LB   3'b000 
`define LH   3'b001 
`define LW   3'b010 
`define LBU  3'b100 
`define LHU  3'b101 
