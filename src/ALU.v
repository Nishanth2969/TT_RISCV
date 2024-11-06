`include "header.vh"

module ALU(

input wire [31:0] opdA,
input wire [31:0] opdB,
input wire [3:0] op_sel,
output reg [31:0] out
);

//Perform ALU operation based on operation select input
    always_latch begin
    case(op_sel)
        `ADD: out = opdA + opdB;
        `SUB: out = opdA - opdB;
        
        `XOR: out = opdA ^ opdB;
        `OR: out = opdA | opdB;
        `AND: out = opdA & opdB;
        
        `SRL: out = opdA >> opdB[4:0];
        `SRA: out = $signed(opdA) >>> opdB[4:0];
        `SLL: out = opdA << opdB[4:0];
        `SLT: out =  $signed(opdA) < $signed(opdB);
        `SLTU: out = $unsigned(opdA) < $unsigned(opdB);
         default: out = out;
    endcase
end
            
endmodule
