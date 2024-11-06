//1. Including the  required Header Files, Defining the Instruction Set Codes in it:
//===================================================================================================================================================
`include "header.vh"

//===================================================================================================================================================
//2. Parameter Declarations:
//===================================================================================================================================================
//parameter len_OpBranch=3;
//parameter len_Operand=32;

//===================================================================================================================================================
//3. Module Definition:
//===================================================================================================================================================
module BranchComparator
	(
		//Branch Operation Selection Port Defintion:=>3-bits:
		input wire [2:0] opBranch,
		
		//Operand-1 of the Branch Instruction:=>32-bits:
		input wire [31:0] operand1,
		
		//Operand-2 of the Branch Instruction:=>32-bits:
		input wire [31:0] operand2,
		
		//Branch Comparator Output:=>1-bit:
		output wire outBranch
	);

	//Intermediate Element to store the outputs:    
	reg outBranch_temp;

//===================================================================================================================================================
// 4.  Always block begin, with all port sensitivity:  
//===================================================================================================================================================   
	always@(*) 
	begin
		
		//***************************************
		//4.1: Case Statement to select the type of the Branch Instruction to be executed:
		//***************************************
		case(opBranch)
			
			//-----------------------------------
			//4.1.1:  Branch for Equality check:
			//-----------------------------------
			`BEQ:	outBranch_temp = (operand1==operand2) ? 1:0;
			
			//-----------------------------------
			//4.1.2: Branch for Inequality Check:
			//-----------------------------------
			`BNE:	outBranch_temp = (operand1!=operand2) ? 1:0;
			
			//-----------------------------------
			//4.1.3: Branch for Less than Operation:(Signed Operation):
			//-----------------------------------
			`BLT:	outBranch_temp = ($signed(operand1) < $signed(operand2)) ? 1:0;
			
			//-----------------------------------
			//4.1.4: Branch for Greater than or Equal Operation: (Signed Operation):
			//-----------------------------------
			`BGE:	outBranch_temp = ($signed(operand1) < $signed(operand2)) ? 0:1;
			
			//-----------------------------------
			//4.1.5: Branch for Less Than Operation: (Unsigned Operation)
			//-----------------------------------
			`BLTU:	outBranch_temp = (operand1 < operand2)? 1:0;
			
			//-----------------------------------
			//4.1.6: Branch for Greater Than or Equal To: (Unsigned Operation):
			//-----------------------------------
			`BGEU:	outBranch_temp = (operand1 < operand2)? 0:1;
			
			//-----------------------------------
			//4.1.7: Default case for the switch case:
			//-----------------------------------
			default: outBranch_temp = 1'b0;
		
		//***************************************
		//4.2: Case Block End:
		//***************************************
		endcase
	
	//***************************************
	//4.3: Always block End:
	//***************************************
	end

//===================================================================================================================================================	
//5. Loading the computed output into the output of the Branch Comparator:
//===================================================================================================================================================    
assign outBranch = outBranch_temp;
		
//===================================================================================================================================================
//6. End of the Branch Comparator Module:
//===================================================================================================================================================
endmodule
