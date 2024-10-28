`timescale 1ns / 1ps

`define DEHIT 13296397
`define SRIRAM 13695918 
`define RISHABH 15597471
`define RAM_LENGTH_WORDS 1024

module DMEM_TB();

reg [31:0] addr_in;
reg [31:0] data_in;
reg [3:0] we;
reg clk;
reg rd;
reg rst;
wire [31:0] data_out;
integer i;
reg [31:0] rand_wdata;

DMEM DUT (.addr_in(addr_in), .data_in(data_in), .we(we), .clk(clk), .rd(rd), .rstn(rst), .data_out(data_out), .load_select(3'b010));

initial clk = 0;
always #10 clk = !clk;

initial begin
rst <= 0;
#100;

rst <= 1; 
#20; 
data_in <= 32'hFEDCBA98;
we <= 4'b0000;
rd <= 1;
//N NUMBER CASES
addr_in <= 32'h00100000;
#20;
if(data_out == 32'h`DEHIT) $display("TEST PASS for first N number"); else $fatal("TEST FAILED at time %0t", $time);
#20;

addr_in <= 32'h00100004;
#20;
if(data_out == 32'h`SRIRAM) $display("TEST PASS for second N number"); else $fatal("TEST FAILED at time %0t", $time);
#20;
// read N numbers and match
addr_in <= 32'h00100008;
#20;
if(data_out == 32'h`RISHABH) $display("TEST PASS for third N number"); else $fatal("TEST FAILED at time %0t", $time);
#20;
//SWITCH ONLY
addr_in <= 32'h00100010;
#20;
if(data_out == 32'h0) $display("TEST PASS for switch"); else $fatal("TEST FAILED at time %0t", $time);
#20;
//LED READ
addr_in <= 32'h00100014;
#20;
if(data_out == 32'h0) $display("TEST PASS for LED read"); else $fatal("TEST FAILED at time %0t", $time);
#20;
//LED WRITE
addr_in <= 32'h00100014;
we <= 1;
#40;
if(data_out == 32'hFEDCBA98) $display("TEST PASS for LED write"); else $fatal("TEST FAILED at time %0t", $time);
#20;

we <= 4'b1111;

//RANDOM CASES
for (i=0; i<`RAM_LENGTH_WORDS; i=i+1) begin
addr_in = 32'h80000000 + i;
rand_wdata = $random;
data_in = rand_wdata;
#40;
if(data_out == rand_wdata) $display("Expected value matches value at ram[%0d]", i); else $fatal("TEST FAILED for ram[%d] at time %0t", i, $time);
#20;
end

$display("All test cases passed");
$finish;

end

endmodule
