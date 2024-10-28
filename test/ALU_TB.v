`timescale 1ns / 1ps

module ALU_TB();
`define INOUT_LEN 32
`define SEL_LEN 4
reg [`INOUT_LEN-1:0] opdA_tb,opdB_tb;
reg [`SEL_LEN-1:0] op_sel_tb;
wire [`INOUT_LEN-1:0] out_tb;

ALU DUT(.opdA(opdA_tb),.opdB(opdB_tb),.op_sel(op_sel_tb),.out(out_tb));
reg [31:0] opdA_f,opdB_f;
reg [3:0] op_sel_f;
reg [31:0] out_f;

integer file_test_cases;

initial begin: ALU

   file_test_cases = $fopen("ALU_Testcases.csv","r");
    if (file_test_cases == 0) begin
        $display("Error opening test cases file");
        $stop;
    end
    $display("Test cases file opened successfully.");
       

    while( !$feof(file_test_cases)) begin
        $fscanf(file_test_cases,"%h,%h,%h,%h",opdA_f,opdB_f,op_sel_f,out_f);
        opdA_tb = opdA_f;
        opdB_tb = opdB_f;
        op_sel_tb = op_sel_f;
        #5;
        if (out_tb != out_f) begin
            $display("ALU Ouptut is incorrect at %t. Try again.",$time);
            $stop;
        end         
    end
    
    $fclose(file_test_cases);
    $display("All testcases passed!");
    $finish;
end 

endmodule
