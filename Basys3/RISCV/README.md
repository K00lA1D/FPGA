# RISC-V CPU Project

## Overview
This project is a complete implementation of a RISC-V CPU using SystemVerilog. The project includes several modules that work together to form a functional CPU. The main components include the Arithmetic Logic Unit (ALU), Control Unit, Program Counter, Register File, Memory, and various supporting modules.

## Files and Modules

### `alu.sv`
Implements the Arithmetic Logic Unit (ALU), which performs arithmetic and logical operations.

### `clock_enable_generator.sv`
Generates the clock enable signal to control the timing of operations in the CPU.

### `control_unit.sv`
Manages the control signals for the CPU, directing the operation of the ALU, memory, and other components.

### `cpu_testbench.sv`
Testbench for simulating and verifying the functionality of the CPU.

### `debounce.sv`
Implements a debouncing circuit to handle noisy input signals, ensuring stable input.

### `display_mux.sv`
Multiplexes multiple display signals, allowing different outputs to be shown on a 7-segment display.

### `hex_to_7seg.sv`
Converts hexadecimal values to signals that drive a 7-segment display.

### `memory.sv`
Implements the memory module used for instruction and data storage.

### `program_counter.sv`
Manages the program counter, keeping track of the address of the next instruction to be executed.

### `register_file.sv`
Implements the register file, providing a set of registers for use by the CPU.

### `top_module.sv`
The top-level module that integrates all the components of the CPU.

### `synchronizer.sv`
Implements a synchronizer to manage asynchronous signals and ensure proper timing within the CPU.

### `risc_v_constraints.xdc`
Contains the constraints file for the RISC-V CPU, specifying timing and other implementation details for the FPGA.

## How to Use

1. **Set up your FPGA environment:** Ensure you have the necessary tools and environment set up to work with your FPGA board and SystemVerilog.
2. **Compile the project:** Use your FPGA toolchain to compile the SystemVerilog files and generate the necessary programming file.
3. **Load the program onto the FPGA:** Use the generated programming file to configure your FPGA.
4. **Run the testbench:** Use the testbench file (`cpu_testbench.sv`) to verify the functionality of the CPU through simulation.

## Dependencies

- SystemVerilog compiler
- FPGA toolchain (e.g., Xilinx Vivado)
- Testbench environment for simulation

## Author

Sid Nair, a third-year Computer Engineering student at UCSD with interests in FPGA/Computer architecture, digital design, and software development. Sid has experience working with both Intel and Loadstar Sensors.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

