`timescale 1ns / 1ps

module Processor_TopModule_TB( );
reg CLK_tb, RST_tb;
reg [15:0] SWITCH_tb;
wire[15:0] LED_tb;
wire [6:0] SEG_tb;
wire [3:0] AN_tb;

ProcessorTopModule DUT(.CLK(CLK_tb),.BTN(RST_tb),.SWITCH(SWITCH_tb),.LED(LED_tb),.SEG(SEG_tb),.AN(AN_tb));

reg RST_f;
reg [15:0] SWITCH_f, LED_f;
reg [3:0] AN_f;

integer file_test_cases;
integer CC;
parameter CLK_PERIOD = 40;
always #(CLK_PERIOD/2) CLK_tb = ~ CLK_tb;
initial begin
    file_test_cases = $fopen("Factorial_Testcases.csv","r");
    //file_test_cases = $fopen("rc5_Testcases.csv","r");
    //file_test_cases = $fopen("Integration_Testcases.csv","r");
    if (file_test_cases == 0) begin
        $display("Error opening test cases file");
        $stop;
    end
    
    CLK_tb = 0;
    RST_tb = 1;
    #(CLK_PERIOD * 10);
    LED_f = 16'h0000;
    AN_f = 4'h0;
    
    while( !$feof(file_test_cases)) begin
    
    if ((SEG_tb !== 7'h00) || (AN_tb !== AN_f)) begin
            $display("HALT output incorrect at %0t ps.",$time);
        end
    
    if (LED_tb !== LED_f) begin
            $display("LED output incorrect at %0t ps.",$time);
        end
        $fscanf(file_test_cases,"%b,%h,%h,%h,%d",RST_f,SWITCH_f,LED_f,AN_f,CC);
        
        RST_tb = RST_f;
        SWITCH_tb = SWITCH_f;
        
        #(CLK_PERIOD*CC);
     
    end
    
    $fclose(file_test_cases);
    $display("All testcases passed!");
 
    $finish;

end

endmodule
