//===================================================================================================================================================
//0. Including the Header Files, Defining the Instruction Set Codes:
//==================================================================================================================================================
`include "header.vh" //Can be ignored in this case currently.

//===================================================================================================================================================
//1. Module Declaration for IMMEDIATE EXTENDER:
//===================================================================================================================================================
module immediateExtender
(
    input wire [31:0] instruction,
    output reg signed [31:0] imm
);

//===================================================================================================================================================
//2. Funct3 and opCode Definition:
//===================================================================================================================================================
wire [2:0] funct3;    
wire [6:0] opCode;

//===================================================================================================================================================
//3. Configuring the funct3 and opCode sections from the instruction input:
//===================================================================================================================================================
assign funct3 = instruction[14:12];
assign opCode = instruction[6:0];

//===================================================================================================================================================
//3. Always Block bEgin for the IMMEDIATE EXTENDER:
//===================================================================================================================================================
always @(*)begin
	case(opCode)
		//Implementing the following using the Concatenation Operator along with respective instruction indexing for the desired operation.
		
		//U-TYPE INSTRUCTIONS:
		`AUIPC,`LUI: imm = { instruction[31:12]    , {12{1'b0}} };
		
		//J-Type INSTRUCTIONS:
		`JAL: imm = { {12{instruction[31]}} , instruction[19:12] , instruction[20]    , instruction[30:21] , 1'b0 };
		
		//I-Type INSTRUCTIONS:
		`JALR: imm = { {21{instruction[31]}} , instruction[30:20] };
		
		//B-TYPE INSTRUCTIONS:
		`BRANCH: imm = { {20{instruction[31]}} , instruction[7]     , instruction[30:25] , instruction[11:8]  , 1'b0 };
		
		 //S-TYPE INSTRUCTIONS:
		`STORE: imm = { {21{instruction[31]}} , instruction[30:25] , instruction[11:7]  };
		
		 //L-TYPE INSTRUCTIONS:
		`LOAD: imm = { {21{instruction[31]}} , instruction[30:20] };
		
		//UNIQUE IMM FOR SHIFT OPERATION:
		`IMM: imm = (funct3[0] && ~funct3[1]) ? { {27{1'b0}} , instruction[24:20] } : { {21{instruction[31]}} , instruction[30:20] };
		
		//DEFAULT CASE:
		default: imm = { 32{1'b0} };
	
	//END OF CASE BLOCK:
	endcase

//END OF ALWAYS BLOCK:
end


//END OF MODULE:
endmodule
