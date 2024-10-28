`timescale 1ns / 1ps

module PC_TB();

reg clk_tb, rst_tb, WEN_tb, IMM_tb;
reg [31:0] IMM_addr_tb;
wire [31:0] inst_addr_tb;
wire HALT_tb;

PC DUT(.clk(clk_tb),.rst(rst_tb),.WEN(WEN_tb),.IMM(IMM_tb),.IMM_addr(IMM_addr_tb),.inst_addr(inst_addr_tb),.HALT_pc(HALT_tb));

reg rst_f,IMM_f,WEN_f,HALT_f;
reg [31:0] IMM_addr_f, inst_addr_f;

integer file_test_cases;

always #10 clk_tb = ~clk_tb;

initial begin: PC

    file_test_cases = $fopen("PC_Testcases.csv","r");
    if (file_test_cases == 0) begin
        $display("Error opening test cases file");
        $stop;
    end
    $display("Test cases file opened successfully.");
    
    clk_tb = 0;
       

    while( !$feof(file_test_cases)) begin
        $fscanf(file_test_cases,"%b,%b,%b,%h,%h,%b",rst_f,WEN_f,IMM_f,IMM_addr_f,inst_addr_f,HALT_f);
        rst_tb = rst_f;
        WEN_tb = WEN_f;
        IMM_tb = IMM_f;
        IMM_addr_tb = IMM_addr_f;
        #5;
        if ((inst_addr_tb !== inst_addr_f) && (inst_addr_f !== 32'bx)) begin
            $display("Instruction address mismatch at %t. Try again.",$time);
            $stop;
        end      
        #10;   
    end
    
    $fclose(file_test_cases);
    $display("All testcases passed!");
    $finish;
end 

endmodule
