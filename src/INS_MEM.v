`include "header.vh"

module INS_MEM(
    input wire clk,rd,
    input wire [31:0] instr_addr,
    output reg [31:0] instr
    );
        
    //4KB IMEM DEFINED FROM 0x01000000 to 0x01000FFF
    (*rom_style = "block" *) reg [31:0] imem [0:256];
    
    //LOAD IMEM
    //initial $readmemh("rc5.mem", imem);
    initial $readmemh("Integration_IMEM.mem", imem);
    //initial $readmemh("Factorial.mem", imem);

        
    always@(posedge clk)
    begin
        if(rd) instr <= imem[instr_addr[11:2]];
    end
    
endmodule
