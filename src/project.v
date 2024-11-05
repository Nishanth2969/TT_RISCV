/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none

module tt_um_KoushikCSN (
    input  wire [7:0] ui_in,    // Dedicated inputs (a and b)
    output wire [7:0] uo_out,   // Dedicated outputs (result)
    input  wire [7:0] uio_in,   // IOs: Input path (opcode)
    output wire [7:0] uio_out,  // IOs: Output path (carry_out, overflow)
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire Inp;
wire Out;
    
//Input:
assign Inp={ui_in, uio_in};

//Output:
always @(posedge clk) 
begin
        if (rst_n)
        begin
            uio_out <= 8'h0;
            uo_out <= 8'h0;
        end
        else if (uio_oe)
            uio_out <= Inp[31:16];  // Display the low 16 bits
        else    
            uo_out<= Inp[15:0];
end
    assign Out={uio_out,uo_out};
    
ProcessorTopModule ProcessorTopModule(
    .clk(CLK), 
    .rst_n(BTN),
    .Inp(SWITCH),
    .Out(LED),
    .uio_oe(SEG),
    uio_oe(AN)
    );    

endmodule
