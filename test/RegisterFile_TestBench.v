`timescale 1ns / 1ps
/*//===================================================================================================================================================
*** FILE DESCRIPTION: ***
//===================================================================================================================================================
This file indicates/implements the testbench for the RegisterFile Module design implemented in another file. This file will test the normal and the routine testcases and validate for any functional integrity violations.

TEAM AUTHORS: SRIRAM NARAYAN KOUSHIK CHITRAPU, RISHABH GOGNA, DEHIT TRIVEDI.
NETID: SC9948, RG4346, DT2412.

*///===================================================================================================================================================
//1. Parameter Declarations:
//===================================================================================================================================================
//parameter len_Operands_tb=32;
//parameter len_Address_tb=5;

//===================================================================================================================================================
//2. Module Declaration for TestBench:
//===================================================================================================================================================
module RegisterFile_TestBench
(
   //Empty for testbench.
);

//===================================================================================================================================================
//3. Required Register File Signals Declarations for this TestBench:
//===================================================================================================================================================
//*******************************************
// 3.1: Register Port Signals:
//*******************************************
	//Clock, Reset_NegativeLogic, WriteEnable:  
	reg clk_tb,rstn_tb,we_tb;

	//Addresses:
	reg [4:0] rs1_addr_tb, rs2_addr_tb, rd_addr_tb;

	//Input Data:
	reg [31:0] rd_din_tb;

	//Output Data:
	wire [31:0] rs1_dout_tb, rs2_dout_tb;

//*******************************************
// 3.2: Branch Comparator File I/O:
//******************************************* 
reg rstn_tb_f,we_tb_f;
reg [4:0] rs1_addr_tb_f, rs2_addr_tb_f, rd_addr_tb_f;
reg [31:0] rd_din_tb_f, rs1_dout_tb_f, rs2_dout_tb_f;

//===================================================================================================================================================
//4. Module Instantiation for The Testbench:
//===================================================================================================================================================
registerFile regfileDUT(
        .clock(clk_tb),
        .reset_n(rstn_tb),
        .writeEnable(we_tb),
        .rs1_address(rs1_addr_tb),
        .rs2_address(rs2_addr_tb),
        .rd_address(rd_addr_tb),
		.rd_dataIn(rd_din_tb),
        .rs1_dataOut(rs1_dout_tb),
        .rs2_dataOut(rs2_dout_tb)

);

//===================================================================================================================================================
//5. Clock Signal for Simulation:
//===================================================================================================================================================
parameter clk_tb_period=10;
always #5 clk_tb=~clk_tb;

//===================================================================================================================================================
// 6. Reading from File and Loading the data into the Signals declared above in 3.2:
//===================================================================================================================================================
	//*******************************************
	// 6.1:Integer Variable Declaration: 
	//*******************************************
	integer file_test_cases;

	//*******************************************
	// 6.2:Initial Block Begin:
	//*******************************************	
	initial begin
		//--------------------------------------- 
		//6.2.1: TestCases Read from the .csv file:
		//--------------------------------------- 
		file_test_cases = $fopen("RegisterFile_Testcases.csv","r");
		
		//--------------------------------------- 
		//6.2.2: Checking if the file read above testcases is empty or not:
		//--------------------------------------- 
		// if file_test_cases is empty?
		if (file_test_cases == 0) 
		begin
			//Display the following as the above condition has been met and satisfied:
			$display("Error opening test cases file");
			//*******************$Error can be asserted*******************
			
			//Abort the Simulation Execution for this testbench:
			$stop;
		end
		
		//Else Block to be executed:
		else
		begin
			//Display the Following as the if-condition was not satisfied:
			$display("Test cases file opened successfully.");
		end

		//--------------------------------------- 
		//6.2.3: Setting Clock Signal:
		//---------------------------------------
		clk_tb=0;

		//--------------------------------------- 
		//6.2.4: While loop to load the read data into signals and check the operation:
		//--------------------------------------- 
		// Looped until the end of the file:
		while( !$feof(file_test_cases)) 
		begin
			
			//Checking for Expected vs Calculated for rs1:
			if (rs1_dout_tb !== rs1_dout_tb_f) 
			begin
			$display("rs1 output is not as expected!");
			$stop;
			end  
		
			//Checking for Expected vs Calculated for rs2:
			if (rs1_dout_tb !== rs1_dout_tb_f) 
			begin
				$display("rs2 output is not as expected!");
				$stop;
			end   
		
			#50;
 
			//Reading the Inputs from File:
			$fscanf(file_test_cases,"%b,%b,%d,%d,%d,%h,%h,%h",rstn_tb_f, we_tb_f, rs1_addr_tb_f, rs2_addr_tb_f, rd_addr_tb_f, rd_din_tb_f, rs1_dout_tb_f, rs2_dout_tb_f);
	 
	 
			//Mapping the Values:
			rstn_tb = rstn_tb_f;
			we_tb = we_tb_f;
			rs1_addr_tb = rs1_addr_tb_f;
			rs2_addr_tb = rs2_addr_tb_f;
			rd_addr_tb = rd_addr_tb_f;
			rd_din_tb = rd_din_tb_f;     

			#75;                    
             
		end


		//Closing the .csv file:
		$fclose(file_test_cases);
		
		//Displaying if all the testcases passed:
		$display("All testcases passed!");

		$finish;                                                    
		
	//Ending of the Initial Block:
	end 

//===================================================================================================================================================
//6. Branch Comparator Module End:
//===================================================================================================================================================
endmodule