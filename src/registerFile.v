/*===================================================================================================================================================
// 0. Register File Details:
//===================================================================================================================================================
=> RegisterFile block is an array of 32 counts of individual 32-bit registers. 
=> The register file supports two independent register reads and one register write in one clock cycle. 

=> 5 bits are used to address each register.(2^5=32 address combinations)
	Ex: R3 = R1 + R2; The Values are read from R1, R2 and then written into R3 post completion of the operation during that clock cycle.
	
=> As per the design of a RISC-V32 Processor, the "R0" register has been designated special status, i.each Only "Read" value from this register can be done which has been hardwired to equal to zero always.

*///===================================================================================================================================================
//1. Including the Header Files, Defining the Instruction Set Codes:
//==================================================================================================================================================
`include "header.vh" //Can be ignored in this case currently.

//===================================================================================================================================================
//2. Parameter Declarations:
//===================================================================================================================================================
//2.1: Register File Length for Address= 5 bits wide:
//parameter len_RgFAddr=5;

//2.2: Length of the data I/O Operands: 32 bits wide:
//parameter len_Operands=32;

//===================================================================================================================================================
//3. Module Signal Declaration:
//===================================================================================================================================================
module registerFile
(
    //3.1: Clock, Reset and Write Enable-Declaration: INPUT:
	input wire clock,reset_n,writeEnable,
	
	//3.2: Register File Address-Declaration: INPUT:
    input wire [4:0] rs1_address, rs2_address, rd_address,
	
	//3.3: Register File Data-Declaration: INPUT:
    input wire [31:0] rd_dataIn,
	
	//3.4: Register Files Data Read: OUTPUT:
    output wire [31:0] rs1_dataOut, rs2_dataOut
);
    
    integer i;
	
	//3.5: Declaring 32 vector array of register files, each of 32 bits wide:
    reg [31:0] registerFile [0:31];
    
    //3.6: Initially, Iniitializing the R0 = 0: (Constantly Grounded Register)
    initial 
	registerFile[0] = 32'h00000000; //No Non-Zero Read/Write onto this Register;
    
    //3.7: Registers to store the Addresses of rs1 and rs2 Operands:
	reg [4:0] rs1_address_reg, rs2_address_reg;

//===================================================================================================================================================
//4. Always Block Begin: Sensitivity Checked on Positive Clock Edges and Negative Edges of Reset Signal:
//===================================================================================================================================================    
    always@(posedge clock)
    begin
    
        //4.1: Source Registers (rs1, rs2) Addresses update onto the address registers delcared in 3.7: 
		//i.e Reading the Address of the Source Registers (rs1, rs2):
        rs1_address_reg <= rs1_address;
        rs2_address_reg <= rs2_address;
        
        //4.2: Updating the Register File Arrays from R1 until R31 to "0" at Active Low Reset:
        if (reset_n==0) for(i=1;i<32;i=i+1) registerFile[i] <= 32'h00000000; //Reset Operation;
		
        //4.2 Writing data onto Registers( R1 to R31) when Write enable is asserted high:
        else if (writeEnable==1 & rd_address!=5'h00) registerFile[rd_address] <= rd_dataIn;
		end
   
    
//===================================================================================================================================================
//5. Final Update of the REgister Files Output from the registerFile Array:
//=================================================================================================================================================== 
assign rs1_dataOut = registerFile[rs1_address_reg];
assign rs2_dataOut = registerFile[rs2_address_reg];

//====================================================================================================================================================
//6. RegisterFile Module End:
//=================================================================================================================================================== 
endmodule
