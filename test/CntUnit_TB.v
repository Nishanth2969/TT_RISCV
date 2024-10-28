`timescale 1ns / 1ps

module CntUnit_TB();

reg clk_tb, rst_tb, HALT_tb, FE_tb, LD_tb, ST_tb, BR_tb;
reg [3:0] WEN_DMEM_DEC_tb;
wire WEN_PC_tb, WEN_REGF_tb, RDEN_IMEM_tb, RDEN_DMEM_tb;
wire [3:0] WEN_DMEM_tb;

CntUnit DUT(.clk(clk_tb),.rst(rst_tb),.HALT_cnt(HALT_tb),.FE(FE_tb),.LD(LD_tb),.ST(ST_tb),.BR(BR_tb),.WEN_DMEM_DEC(WEN_DMEM_DEC_tb),.WEN_PC(WEN_PC_tb),.WEN_REGF(WEN_REGF_tb),.RDEN_IMEM(RDEN_IMEM_tb),.RDEN_DMEM(RDEN_DMEM_tb),.WEN_DMEM(WEN_DMEM_tb));
initial clk_tb = 0;
always #10 clk_tb = ~clk_tb;

initial begin
    rst_tb <= 0;
    #20
    //R TYPE
    rst_tb <= 1;
    HALT_tb <= 0;
    FE_tb <= 0;
    LD_tb <= 0;
    ST_tb <= 0;
    BR_tb <= 0;
    WEN_DMEM_DEC_tb <= 4'b0000;
    
       
    #120; 
    rst_tb <=0;
    #20; 
    
    //S TYPE
    rst_tb <= 1;
    HALT_tb <= 0;
    FE_tb <= 0;
    LD_tb <= 0;
    ST_tb <= 1;
    BR_tb <= 0;
    WEN_DMEM_DEC_tb <= 4'b1111;
    
        
    #120;
    rst_tb <=0;
    #20;
    
    //I TYPE
    rst_tb <= 1;
    HALT_tb <= 0;
    FE_tb <= 0;
    LD_tb <= 1;
    ST_tb <= 0;
    BR_tb <= 0;
    WEN_DMEM_DEC_tb <= 4'b0000;
    
        
    #120;    
    rst_tb <=0;
    #20;
    
    //B TYPE
    rst_tb <= 1;
    HALT_tb <= 0;
    FE_tb <= 0;
    LD_tb <= 0;
    ST_tb <= 0;
    BR_tb <= 1;
    WEN_DMEM_DEC_tb <= 4'b0000;
    
    
    #120;    
    rst_tb <=0;
    #20;
    
    //HALT (SYS)
    rst_tb <= 1;
    HALT_tb <= 1;
    FE_tb <= 0;
    LD_tb <= 1;
    ST_tb <= 1;
    BR_tb <= 0;
    WEN_DMEM_DEC_tb <= 4'b1111;
     
    
    #120;    
    rst_tb <=0;
    #20;
    
    //FENCE
    rst_tb <= 1;
    HALT_tb <= 0; 
    FE_tb <= 1;   
    LD_tb <= 1;
    ST_tb <= 0;
    BR_tb <= 1;
    WEN_DMEM_DEC_tb <= 4'b1111;
     
    
    #120;  

    $finish();
     
    end



endmodule
