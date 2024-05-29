# 2-to-1 Multiplexer Project

## Overview
This project is a simple implementation of a 2-to-1 multiplexer using Verilog. The project includes the multiplexer module, a testbench for simulation, and a constraints file for FPGA implementation.

## Files and Modules

### `mux2x1.v`
Implements the 2-to-1 multiplexer, which selects between two input signals based on a select signal.

### `mux2x1_constraints.xdc`
Contains the constraints file for the 2-to-1 multiplexer, specifying timing and other implementation details for the FPGA.

### `mux2x1_tb.v`
Testbench for simulating and verifying the functionality of the 2-to-1 multiplexer.

## How to Use

1. **Set up your FPGA environment:** Ensure you have the necessary tools and environment set up to work with your FPGA board and Verilog.
2. **Compile the project:** Use your FPGA toolchain to compile the Verilog files and generate the necessary programming file.
3. **Load the program onto the FPGA:** Use the generated programming file to configure your FPGA.
4. **Run the testbench:** Use the testbench file (`mux2x1_tb.v`) to verify the functionality of the multiplexer through simulation.

## Dependencies

- Verilog compiler
- FPGA toolchain (e.g., Xilinx Vivado)
- Testbench environment for simulation

## Author

Sid Nair, a third-year Computer Engineering student at UCSD with interests in FPGA/Computer architecture, digital design, and software development. Sid has experience working with both Intel and Loadstar Sensors.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

