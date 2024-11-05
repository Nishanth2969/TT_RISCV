/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
//`default_nettype none

module tt_um_KoushikCSN (
    input  wire [7:0] ui_in,    // Dedicated inputs 
    output wire [7:0] uo_out,   // Dedicated outputs 
    input  wire [7:0] uio_in,   // IOs: Input 
    output wire [7:0] uio_out,  // IOs: Output path (carry_out, overflow)
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire [15:0] Out;
    
assign Out={uio_out,uo_out};
    
ProcessorTopModule ProcessorTopModule(
    .CLK(clk), 
    .BTN(rst_n),
    .SWITCH(ui_in),
    .LED(Out),
    .SEG(uio_oe),
    .AN(uio_oe)
    );    

endmodule
