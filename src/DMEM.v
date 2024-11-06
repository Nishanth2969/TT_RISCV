`include "header.vh"

//RAM PARAMETERS
//`define RAM_LENGTH_WORDS 1024
`define RAM_LENGTH_WORDS 256
`define RAM_ADDR_BITS 12
`define STARTING_ADDR_BIT 32

//ROM PARAMETERS
`define ROM_LENGTH 3
`define ROM_ADDR_BIT 21

`define DEHIT 13296397
`define SRIRAM 13695918 
`define RISHABH 15597471

//IO Ports
`define IO_LENGTH 2

module DMEM(
    input wire clk,
    input wire rstn,
    input wire rd,
    input wire [3:0] we,
    input wire [2:0] load_select,
    input wire [31:0] addr_in,
    input wire [31:0] data_in,
    output wire [31:0] data_out,
    input wire [15:0] switch,
    output reg [15:0] led
);
                  
    integer i;
    
    reg [31:0] ram [0:`RAM_LENGTH_WORDS-1];
    
    //DMEM values initialised to zero
    initial $readmemh("dmem_zero.mem", ram);
 
    reg [31:0] rom [0:`ROM_LENGTH -1];
    initial begin
  
        rom[0] = 32'h`DEHIT;   //0X00100000
        rom[1] = 32'h`SRIRAM;   //0X00100004
        rom[2] = 32'h`RISHABH;  //0X00100008
        //led <= 16'h0000;
    end

    wire [11:0] addr;

    assign addr= {2'b00, addr_in[`RAM_ADDR_BITS-1:2]};

    reg [31:0] data_out_raw;

Data_Ext DATA_EXT(.opcode(load_select), .in_data(data_out_raw), .opt_data(data_out));
    reg [31:0] data_out_ram, data_out_rom;
    
    always@(*) begin
        case({addr_in[`ROM_ADDR_BIT-1],addr_in[`STARTING_ADDR_BIT-1]})
            2'b01: data_out_raw = data_out_ram;
            2'b10: data_out_raw = data_out_rom;
            default: data_out_raw = 32'h00000000;
        endcase
    end
 
    wire [3:0] we_ram;
    wire [1:0] we_led;
    
    assign we_ram = addr_in[`STARTING_ADDR_BIT-1] ? we : 4'b0000 ;
    assign we_led = (addr_in[`ROM_ADDR_BIT-1] && addr==12'd5) ? we[1:0] : 2'b00;

    always @(posedge clk) begin  

            if (rd) begin
           	        case(addr)
           	            12'd0,12'd1,12'd2: data_out_rom <= rom[addr];     
           	            12'd4: data_out_rom <= switch;                         
           	            12'd5: data_out_rom <= led;                        
           	            default: data_out_rom <= 32'b0;                   
           	        endcase
           	        if (we_led[0]) led[7:0] <= data_in[7:0];   
           	        if (we_led[1]) led[15:8] <= data_in[15:8];
            
           	        data_out_ram <= ram[addr];   
           	        if (we_ram[0]) ram[addr][7:0] <= data_in[7:0];
           	        if (we_ram[1]) ram[addr][15:8] <= data_in[15:8];                    
           	        if (we_ram[2]) ram[addr][23:16] <= data_in[23:16];
           	        if (we_ram[3]) ram[addr][31:24] <= data_in[31:24];
            end
    end

endmodule
