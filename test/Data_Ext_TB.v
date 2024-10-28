`timescale 1ns / 1ps
`include "header.vh"

module Data_Ext_TB();
    
    reg [2:0] opcode;
    reg [31:0] in_data;
    wire [31:0] opt_data;
    
    Data_Ext DUT (.opcode(opcode), .in_data(in_data), .opt_data(opt_data));
    
    reg error_count = 0;
    
    initial begin
        #5;
        in_data <= 32'h98A48DB7;
        opcode <= `LB;
        #10;
        
        #10;
        opcode <= `LH;
        #10;
        
        #10;
        opcode <= `LW;
        #10;
       
        #10;
        opcode <= `LBU;
        #10;
       
        #10;
        opcode <= `LHU;
        #10;
        
        #10;
        
        $finish;
    end
    
endmodule