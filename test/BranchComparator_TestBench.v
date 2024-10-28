`timescale 1ns / 1ps
/*//===================================================================================================================================================
*** FILE DESCRIPTION: ***
//===================================================================================================================================================
This file indicates/implements the testbench for the BranchComparator Module design implemented in another file. This file will test the normal and the routine testcases and validate for any functional integrity violations.

TEAM AUTHORS: SRIRAM NARAYAN KOUSHIK CHITRAPU(Component Done by me), RISHABH GOGNA, DEHIT TRIVEDI.
NETID: SC9948, RG4346, DT2412.

Branch Operations:
=> BEQ (Branch if Equal): Takes a branch if the two operands are equal.
=> BNE (Branch if Not Equal): Takes a branch if the two operands are not equal.
=> BLT (Branch if Less Than): Takes a branch if the first operand is less than the second (signed operation).
=> BGE (Branch if Greater Than or Equal): Takes a branch if the first operand is greater than or equal to the second (signed operation).
=> BLTU (Branch if Less Than, Unsigned): Takes a branch if the first operand is less than the second (unsigned operation).
=> BGEU (Branch if Greater Than or Equal, Unsigned): Takes a branch if the first operand is greater than or equal to the second (unsigned operation)

*///=================================================================================================================================================
//1. Including the  required Header Files, Defining the Instruction Set Codes in it:
//===================================================================================================================================================
`include "header.vh"

//===================================================================================================================================================
//2. Parameter Declarations:
//===================================================================================================================================================
//parameter len_Operands_tb=32;
//parameter len_OperationBrSel_tb=3;

//===================================================================================================================================================
//3. Module Declaration for TestBench:
//===================================================================================================================================================
module BranchComparator_TestBench
(
   //Empty to indicate it as testbench.
);

//===================================================================================================================================================
//4. Required out_tbComparator Signals Declarations for this TestBench:
//===================================================================================================================================================
// 4.1: Operand Inputs:
//------------------
reg [31:0] opdA_tb,opdB_tb;

//------------------	
//4.2: Operation Selection:
//------------------	
reg [2:0] op_sel_tb;

//------------------
//4.3: Comparator Output: (Calculated/Computed)
//------------------
wire out_tb;

//===================================================================================================================================================
//5. Module Instantiation for The Testbench:
//===================================================================================================================================================
BranchComparator DUTBrCmp(.operand1(opdA_tb),.operand2(opdB_tb),.opBranch(op_sel_tb),.outBranch(out_tb));

//===================================================================================================================================================
// 6. Initial Block Configuration:
//===================================================================================================================================================
initial begin

	//----------------------------------------------------------
	//6.1: DataSet-1: Checking for Greater than conditions:
	//----------------------------------------------------------
	#5;
	opdA_tb <= 32'hff887511; //OPERAND-A
	opdB_tb <= 32'h1f945654; //OPERAND-B
	#10;
	
	//BEQ:
	op_sel_tb <= `BEQ;
	#20;
	if(out_tb!=0) 
	begin
		$error("Operand A is not equal to Operand B in Dataset-1");
	end
	#10;
	
	//BNE:
	op_sel_tb <= `BNE;
	#20;
	if(out_tb!=1)  
	begin
		$error("Operand A is equal to Operand B in Dataset-1");
	end
	#10;
	
	//BGE:
	op_sel_tb <= `BGE;
	#20;
	if(out_tb!=1)  
	begin
		$error("Operand A is less than Operand B in Dataset-1 (Signed)");
	end
	#10;
	
	//BGEU:
	op_sel_tb <= `BGEU;
	#20;
	if(out_tb!=1)  
	begin
		$error("Operand A is less than Operand B in Dataset-1 in unsigned operation.");
	end
	#10;

	//BLT:
	op_sel_tb <= `BLT;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is greater than Operand B in Dataset-1 (signed)");
	end
	#10;
	
	//BLTU:
	op_sel_tb <= `BLTU;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is greater than Operand B in Dataset-1(Unsigned)");
	end
	#10;	
	
	//----------------------------------------------------------
	//6.2: DataSet-2: Checking for Equality conditions:
	//----------------------------------------------------------	
	#5;
	opdA_tb <= 32'h1234ABCD; //OPERAND-A
	opdB_tb <= 32'h1234ABCD; //OPERAND-B
	#20;
	
	//BEQ:
	op_sel_tb <= `BEQ;
	#20;
	if(out_tb!=1)  
	begin
		$error("Operand A is not equal to Operand B in Dataset-2");
	end
	#10;
	
	//BNE:
	op_sel_tb <= `BNE;
	#20;
	if(out_tb!=0) 
	begin
		$error("Operand A is equal to Operand B in Dataset-2");
	end
	#10;
	
	//BLT:
	op_sel_tb <= `BLT;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is less than Operand B in Dataset-2(Signed)");
	end
	#10;
	
	//BLTU:
	op_sel_tb <= `BLTU;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is less than Operand B in Dataset-2 (unsigned)");
	end
	#10;
	
	//BGE:
	op_sel_tb <= `BGE;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is greater than Operand B in Dataset-2 (signed)");
	end
	#10;
	
	//BGEU:
	op_sel_tb <= `BGEU;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is greater than Operand B in Dataset-2 (unsigned)");
	end
	#10;
	
	//----------------------------------------------------------
	//6.3: DataSet-3: Checking for LESS THAN conditions:
	//----------------------------------------------------------		
	#5;
	opdA_tb <= 32'h1234ABCD; //OPERAND-A
	opdB_tb <= 32'hF6CA815F; //OPERAND-B
	#10;
	
	//BEQ:
	op_sel_tb <= `BEQ;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is not equal to Operand B in Dataset-3");
	end
	#10;
	
	//BNE:
	op_sel_tb <= `BNE;
	#20;
	if(out_tb!=1)  
	begin
		$error("Operand A is equal to Operand B in Dataset-3");
	end
	#10;
	
	//BLT:
	op_sel_tb <= `BLT;
	#20;
	if(out_tb!=1)  
	begin
		$error("Operand A is greater than Operand B in Dataset-3 (Signed)");;
	end
	#10;
	
	//BLTU:
	op_sel_tb <= `BLTU;
	#20;
	if(out_tb!=1)  
	begin
		$error("Operand A is greater than Operand B in Dataset-3 (UnSigned)");
	end
	#10;
	
	//BGE:
	op_sel_tb <= `BGE;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is less than Operand B in Dataset-3 (Signed)");
	end
	#10;
	
	//BGEU:
	op_sel_tb <= `BGEU;
	#20;
	if(out_tb!=0)  
	begin
		$error("Operand A is less than Operand B in Dataset-3 (UnSigned)");
	end
	#10;
	$finish;
end

//===================================================================================================================================================
//7. Comparator Module End:
//===================================================================================================================================================
endmodule