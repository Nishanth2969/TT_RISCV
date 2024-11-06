/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
//`default_nettype none

module tt_um_KoushikCSN (
    input  wire [7:0] ui_in,        // Dedicated inputs 
    output reg  [7:0] uo_out,       // Dedicated outputs 
    input  wire [7:0] uio_in,       // IOs: Input 
    output reg  [7:0] uio_out,      // IOs: Output path (carry_out, overflow)
    output reg  [7:0] uio_oe,       // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,          // always 1 when the design is powered, so you can ignore it
    input  wire       clk,          // clock
    input  wire       rst_n         // reset_n - low to reset
);

    reg [15:0] Out;  // Internal register for combined output values
    reg [15:0] SWITCH; // Extended switch inputs for ProcessorTopModule

    // Sequential logic to update `Out`, `uo_out`, and `uio_out`
    always @(posedge clk or negedge rst_n) 
	begin
            // Assign combined inputs to `SWITCH` and set `Out` based on `SWITCH`
            SWITCH <= {uio_in, ui_in};  // Combining inputs to form 16-bit `SWITCH`
            
            // Split `Out` into `uo_out` and `uio_out` parts
            uo_out <= Out[7:0];         // Lower 8 bits of Out assigned to uo_out
            uio_out <= Out[15:8];       // Upper 8 bits of Out assigned to uio_out
            uio_oe <= 8'b1;      		// Set output enable for `uio_out`
    end

    // Instantiate the ProcessorTopModule
    ProcessorTopModule ProcessorTopModule_inst (
        .CLK(clk), 
        .BTN(rst_n),
        .SWITCH(SWITCH),       // 16-bit input switch
        .LED(Out),             // 16-bit output LED driven by Out
        .SEG(uio_out),         // Connect 8-bit SEG to upper 8 bits of Out
        .AN(uio_oe[3:0])       // Use only 4 bits for AN as per module definition
    );    

endmodule
