`include "header.vh"

module CntUnit(
    input wire clk, rst, HALT_cnt, FE, LD, ST, BR,
    input wire [3:0] WEN_DMEM_DEC,
    output reg WEN_PC, WEN_REGF, RDEN_IMEM, RDEN_DMEM,
    output reg [3:0] WEN_DMEM

    );

// STATES
    localparam IF = 3'd0;     
    localparam IDEX = 3'd1;     
    localparam MEM = 3'd2;     
    localparam WB = 3'd3;     
    localparam HALT_c = 3'd4;     
//initial state <= 3'b000;    //Start with IF state
reg [2:0] state, nextstate;
always @(posedge clk or negedge rst) begin   //State cycling
        if(!rst) begin
            state <= IF;    //Reset to IF state
        end
        else 
            state <= nextstate;    //Else cycle to next state
    end
always @(*) begin   //Update outputs depending on state
    
        RDEN_IMEM <= 0;
        WEN_PC <= 0;    
        WEN_REGF <= 0;
        RDEN_DMEM <= 0;
        WEN_DMEM <= 4'd0;
            
            case (state)
                //Instruction Fetch
                IF: begin  
                     RDEN_IMEM <= 1;
                     nextstate = IDEX;
                 end
                 
                 //Instruction Decode and Execute
                 IDEX: begin
                        if(HALT_cnt) nextstate = HALT_c; //Stop execution if HALT is asserted
                        else if(LD | ST) 
                            nextstate = MEM;  //If the operation is a load or store operation, cycle to the Memory read/write state
                        else 
                            nextstate = WB;
                  end
                  
                  //Memory Operation
                  MEM: begin
                        RDEN_DMEM <= 1;
                        if(ST) WEN_DMEM <= WEN_DMEM_DEC;    //Decoder write enable sent to Control Unit DMEM write enable for store operation 
                        nextstate = WB;   //Cycle to WB state
                   end
                   
                   //Writeback
                   WB: begin
                        WEN_PC <= 1;  //Write to register file + update PC
                        if(!(ST | BR | FE)) begin 
                            WEN_REGF <= 1;
                        end
                        nextstate = IF;
                    end
                    
                    //Halt
                    HALT_c: begin    //Stop execution
                     end
            endcase
    end        
endmodule     






