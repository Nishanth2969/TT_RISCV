`timescale 1ns / 1ps
//===================================================================================================================================================
//1. Module Declaration for IMMEDIATE EXTENDER TESTBENCH:
//===================================================================================================================================================
module immediateExtender_TestBench
(
	//Empty for Testbench.
);

//===================================================================================================================================================
//2. Required Signals Defined:
//===================================================================================================================================================
reg [31:0] instruction_Tb;
wire [31:0] immE_tb;

//===================================================================================================================================================
//3. Module INSTANTIATION for IMMEDIATE EXTENDER:
//===================================================================================================================================================
immediateExtender DUT(.instruction(instruction_Tb), .imm(immE_tb));

//===================================================================================================================================================
//4. TEST CASES FOR THE IMMEDIATE EXTENDER:
//===================================================================================================================================================
initial begin

	//1. J-TYPE INSTRUCTION VALIDATION:
	instruction_Tb <= 32'hfdeab0ef;
	#10;
	 if(immE_tb!=32'hfffab7de) 
	 begin
		$error("Not J-Type instruction Expected Output");
		$stop;
	end

	 #10;
	//2. I-TYPE INSTRUCTION VALIDATION:
	instruction_Tb <= 32'h03746293;
	#10;
	 if(immE_tb!=32'h00000037) 
	 begin
		$error("Not I-Type instruction Expected Output");
		$stop;
	end

	#10;
	//3. B-TYPE INSTRUCTION VALIDATION:
	instruction_Tb <= 32'hfdf545e3;
	#10;
	 if(immE_tb!=32'hffffffca) 
	 begin
		$error("Not B-Type instruction Expected Output");
		$stop;
	end

	#10;
	//4. S-TYPE INSTRUCTION VALIDATION:
	instruction_Tb <= 32'hfd129a23;
	#10;
	 if(immE_tb!=32'hffffffd4) 
	 begin
		$error("Not S-Type instruction Expected Output");
		$stop;
	end

	#10;
	//5. U-TYPE INSTRUCTION VALIDATION:
	instruction_Tb <= 32'hfac01f17;
	#10;
	 if(immE_tb!=32'hfac01000) 
	 begin
		$error("Not U-Type instruction Expected Output");
		$stop;
	end

	 #10;

	//All Test Cases have been checked and passed successfully!.
	$display("All test cases passed");
	
	//End of Simulation:
	$finish;

//End of INITIAL BLOCK:    
end

//END OF TESTBENCH MODULE FOR THE IMMEDIATE EXTENDER:
endmodule