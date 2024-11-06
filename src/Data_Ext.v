`include "header.vh"

module Data_Ext(

    input wire [2:0] opcode,
    input wire [31:0] in_data,
    output wire [31:0] opt_data

    );
    
    reg [31:0] d_out;
    
    always@(*) begin 
        case(opcode)
            `LB: d_out = {{24{in_data[7]}}, in_data[7:0]};
            `LH: d_out = {{16{in_data[15]}}, in_data[15:0]};
            `LBU: d_out = {{24{1'b0}}, in_data[7:0]};
            `LHU: d_out = {{16{1'b0}}, in_data[15:0]};
            `LW: d_out = in_data;
            default: d_out = 32'd0;
           endcase    
        end 
        
        assign opt_data = d_out;
         
endmodule
