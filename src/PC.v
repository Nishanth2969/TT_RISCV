`include "header.vh"

module PC(
    input wire clk, rst, WEN, IMM,
    input wire [31:0] IMM_addr,
    output wire [31:0] inst_addr,
    output reg HALT_pc

    );
reg [31:2] inst_add_reg, temp_inst_add;

always @(posedge clk or negedge rst)
    begin
        if (rst == 0)  //Reset to start of IMEM
            begin
                inst_add_reg <= 30'h01000000/4;
                HALT_pc <= 1'b0;
            end
            else begin
                    if (WEN == 1) begin //Update Program Counter when WEN is asserted by Control Unit   
                        if (IMM == 1) temp_inst_add <= IMM_addr[31:2];    //Immediate address when IMM is asserted
                            else temp_inst_add <= inst_addr[31:2] + 1;   //4 Byte increment
                            
                            if (temp_inst_add > 30'h01000FFC/4 | temp_inst_add < 30'h01000000/4) HALT_pc <= 1'b1;    // HALT_pc asserted if Program Counter reaches values out of the lower and upper IMEM limit
                            
                            inst_add_reg <= temp_inst_add;  //Clock the instruction address to its register
                         end
                 end            
end
assign inst_addr = {inst_add_reg,2'b00};
endmodule
