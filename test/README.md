# Testbench for a Tiny Tapeout project

This is a testbench for a Tiny Tapeout project. It uses [cocotb](https://docs.cocotb.org/en/stable/) to drive the DUT and check the output assertions.
See below to get started or for more information, check the [website](https://tinytapeout.com/hdl/testing/).

## Setting up

1. Edit [Makefile](Makefile) and modify `PROJECT_SOURCES` to point to your correct Verilog files.
2. Edit [tb.v](tb.v) and replace `tt_um_example` with your module name.
3. Ensure the test.py contains apt testcases

## How to run

To run the RTL simulation:

```sh
make -B
```

To run gatelevel simulation, first harden your project and copy `../runs/wokwi/results/final/verilog/gl/{your_module_name}.v` to `gate_level_netlist.v`.

Then run:

```sh
make -B GATES=yes
```

## How to view the VCD file

```sh
gtkwave tb.vcd tb.gtkw
```
