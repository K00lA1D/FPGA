/*
`timescale 1ns / 1ps

module cpu_core(
    input wire clk,
    input wire reset,
    input wire [31:0] instruction,
    input wire jump,
    //mem signals
    input wire mem_read_enable,
    input wire mem_write_enable,
    input wire [31:0] mem_read_data,
    input wire [31:0] mem_write_data,
    //reg signals
    input wire reg_write_enable,
    input wire [4:0] reg_read_addr1,
    input wire [4:0] reg_read_addr2,
    input wire [4:0] reg_write_addr,
    input wire [31:0] reg_read_data1,
    input wire [31:0] reg_read_data2,
    //alu signals
    input wire [3:0] alu_op,
    output reg [31:0] alu_result
);

    wire [31:0] pc;

    // Updated to use a register for instruction
    reg [31:0] current_instruction;

    task execute_instruction(input [31:0] instruction);
        begin
            current_instruction = instruction;
        end
    endtask

    control_unit control_unit_module(
        .instruction(current_instruction), // Use the register
        .jump(jump),
        .alu_op(alu_op),
        //memory
        .mem_read_enable(mem_read_enable),
        .mem_write_enable(mem_write_enable),
        //registers
        .reg_write_enable(reg_write_enable),
        .reg_write_addr(reg_write_addr),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2)
    );

    alu alu_module(
        //inputs
        .operand_a(reg_read_data1),
        .operand_b(reg_read_data2),
        .op_code(alu_op),
        //output
        .result(alu_result)
    );

    register_file register_file_module(
        //inputs
        .clk(clk),
        .reset(reset),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .reg_write_addr(reg_write_addr),
        .reg_write_data(alu_result),
        .reg_write_enable(reg_write_enable),
        //outputs
        .reg_read_data1(reg_read_data1),
        .reg_read_data2(reg_read_data2)
    );

    memory memory_module(
        //inputs
        .clk(clk),
        .mem_addr(alu_result),
        .mem_write_data(mem_write_data), 
        .mem_read_enable(mem_read_enable), 
        .mem_write_enable(mem_write_enable),
        //output
        .mem_read_data(mem_read_data)
    );

    program_counter pc_module(
        //inputs
        .clk(clk),
        .reset(reset),
        .jump_addr(alu_result), 
        .jump(jump),
        //output
        .pc(pc)
    );

endmodule
*/