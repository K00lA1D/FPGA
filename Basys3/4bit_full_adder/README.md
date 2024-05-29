# 4-bit Full Adder Project

## Overview
This project is an implementation of a 4-bit full adder using Verilog. The project includes the full adder module, a 4-bit full adder module, a testbench for simulation, and a constraints file for FPGA implementation.

## Files and Modules

### `fulladd.v`
Implements a 1-bit full adder, which performs binary addition of three input bits (two significant bits and a carry-in).

### `fulladd4.v`
Implements the 4-bit full adder, which uses four instances of the 1-bit full adder to perform binary addition of two 4-bit numbers and a carry-in.

### `testbench.v`
Testbench for simulating and verifying the functionality of the 4-bit full adder.

### `basys3_constraints.xdc`
Contains the constraints file for the 4-bit full adder, specifying timing and other implementation details for the FPGA.

## How to Use

1. **Set up your FPGA environment:** Ensure you have the necessary tools and environment set up to work with your FPGA board and Verilog.
2. **Compile the project:** Use your FPGA toolchain to compile the Verilog files and generate the necessary programming file.
3. **Load the program onto the FPGA:** Use the generated programming file to configure your FPGA.
4. **Run the testbench:** Use the testbench file (`testbench.v`) to verify the functionality of the 4-bit full adder through simulation.

## Dependencies

- Verilog compiler
- FPGA toolchain (e.g., Xilinx Vivado)
- Testbench environment for simulation

## Author

Sid Nair, a third-year Computer Engineering student at UCSD with interests in FPGA/Computer architecture, digital design, and software development. Sid has experience working with both Intel and Loadstar Sensors.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

