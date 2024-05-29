

module top_module(
    input logic clk,
    input logic btn_reset,  // Reset button input
    // FPGA visuals
    output logic [15:0] leds,
    output logic [6:0] seg,
    output logic [3:0] an
    //output logic seg_dp
);

logic [31:0] alu_result;
logic [31:0] reg_read_data1;
logic [31:0] reg_read_data2;
logic clk_slow;
logic reset;
logic [31:0] mem_read_data;
logic [31:0] program_counter;
logic [4:0] alu_op;
logic [11:0] immediate;
logic [2:0] load_operation;
logic [2:0] store_operation;
logic jump;
logic mem_read_enable, mem_write_enable;
logic reg_write_enable;
logic reg_read_enable;
logic [4:0] reg_read_addr1, reg_read_addr2, reg_write_addr;
logic [31:0] instruction;


debounce debounce_inst (
    .clk(clk),
    .btn(btn_reset),
    .btn_clean(reset)
);

clock_enable_generator clock_enable_gen (
    .clk_in(clk),
    .rst(btn_reset),
    .clk_enable(clk_slow)
);

control_unit control_unit_inst (
    //inputs
    .instruction(instruction),
    .alu_op(alu_op),
    //outputs
    .mem_read_enable(mem_read_enable),
    .mem_write_enable(mem_write_enable),
    .reg_read_enable(reg_read_enable),
    .reg_write_enable(reg_write_enable),
    .reg_write_addr(reg_write_addr),
    .reg_read_addr1(reg_read_addr1),
    .reg_read_addr2(reg_read_addr2),
    .immediate(immediate),
    .load_operation(load_operation),
    .store_operation(store_operation),
    .jump(jump)
);

alu alu_inst (
    //inputs
    .operand_a(reg_read_data1),
    .operand_b(reg_read_data2),
    .immediate(immediate),
    .op_code(alu_op),
    //outputs
    .result(alu_result),
    .zero()
);

register_file register_file_inst (
    //inputs
    .clk(clk_slow),
    .reset(reset),
    .reg_read_addr1(reg_read_addr1),
    .reg_read_addr2(reg_read_addr2),
    .reg_write_addr(reg_write_addr),
    .reg_write_data(alu_result),
    .load_operation(load_operation),
    .reg_write_enable(reg_write_enable),
    .reg_read_enable(reg_read_enable),
    .read_from_mem(mem_read_enable),
    .data_from_mem(mem_read_data),
    //outputs
    .reg_read_data1(reg_read_data1),
    .reg_read_data2(reg_read_data2)
);

memory memory_inst (
    //inputs
    .clk(clk_slow),
    .reset(reset),
    .mem_addr(alu_result),
    .store_operation(store_operation),
    .mem_write_enable(mem_write_enable),
    .mem_read_enable(mem_read_enable),
    .read_from_reg(reg_read_enable),
    .data_from_reg(reg_read_data2),
    .instr_addr(program_counter),
    //outputs
    .instruction(instruction),
    .mem_read_data(mem_read_data)
);

program_counter pc_inst (
    .clk(clk_slow),
    .reset(reset),
    .jump_addr(alu_result),
    .jump(jump),
    .pc(program_counter)
);


display_mux display_mux_inst (
    .clk(clk),                // Use fast clock for display update
    .reset(reset),
    .value(program_counter[15:0]), 
    .an(an),
    .seg(seg)
);

always_ff @(posedge clk_slow or posedge reset) begin
    if (reset) begin
        $display("Resetting at time: %0t", $time);
    end else begin
        $display("Instruction : %h", instruction);
    end
end

// LED assignments
assign leds[0] = alu_op[0]; // Least significant bit of ALU operation
assign leds[1] = alu_op[1];
assign leds[2] = alu_op[2];
assign leds[3] = alu_op[3];
assign leds[4] = alu_op[4];
assign leds[5] = mem_read_enable;
assign leds[6] = mem_write_enable;
assign leds[7] = reg_write_enable;
assign leds[8] = instruction[30]; //function 7 toggle
assign leds[9]  = instruction[14];  //function3 [2]
assign leds[10]  = instruction[13];  //function3 [1]
assign leds[11] = instruction[12];  //function3 [0]
assign leds[12] = (instruction[6:0] == 7'b0110011 ) ? 1 : 0; // Register-Type
assign leds[13] = (instruction[6:0] == 7'b0010011 ) ? 1 : 0; // Immediate-Type
assign leds[14] = (instruction[6:0] == 7'b0000011 ) ? 1 : 0; // Loading
assign leds[15] = (instruction[6:0] == 7'b0100011 ) ? 1 : 0; // Storing

//assign seg_dp = 1'b0; // Decimal point off, can be used to indicate a particular state

endmodule
