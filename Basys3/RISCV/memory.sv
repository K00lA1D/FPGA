`timescale 1ns / 1ps

module memory(
    input logic clk,
    input logic reset,
    input logic [31:0] mem_addr,
    input logic [2:0] store_operation,
    input logic mem_write_enable,
    input logic mem_read_enable,
    input logic read_from_reg,
    input logic [31:0] data_from_reg,
    input logic [31:0] instr_addr,
    output logic [31:0] instruction, // indexed through program counter
    output logic [31:0] mem_read_data
);

    logic [31:0] instr_mem_array [0:255];  // Instruction memory (256 words)
    logic [31:0] data_mem_array [0:767];   // Data memory (768 words)


    localparam DATA_MEM_START = 3'd000; 
    localparam DATA_MEM_END = 3'd192;

    localparam SB = 3'b000;
    localparam SH = 3'b001;
    localparam SW = 3'b010;

    assign mem_read_data = (mem_read_enable && (DATA_MEM_START <= mem_addr < DATA_MEM_END)) ? 
                            data_mem_array[mem_addr >> 2] : 31'b0;

    assign instruction = instr_mem_array[instr_addr >> 2];

    always @(posedge clk or posedge reset) begin

        //$display("In the memory block now");
        if (reset) begin
            integer i;
            //clear all the indices of both memories
            for (i = 0; i < 256; i = i + 1) begin
                instr_mem_array[i] = 32'h00000000;
            end
            for (i = 0; i < 1024; i = i + 1) begin
                data_mem_array[i] = 32'h00000000;
            end

            data_mem_array[5] = 32'hFFFFFFE0;

            //place all the instructions into the instr_memory
            instr_mem_array[0]  = 32'h002081B3;  // ADD rd=3, rs1=1, rs2=2
            instr_mem_array[1]  = 32'h00408193;  // ADDI rd=3, rs1=1, imm=4
            instr_mem_array[2]  = 32'h402081B3;  // SUB rd=3, rs1=1, rs2=2
            instr_mem_array[3]  = 32'h0020F1B3;  // AND rd=3, rs1=1, rs2=2
            instr_mem_array[4]  = 32'h0020E1B3;  // OR rd=3, rs1=1, rs2=2
            instr_mem_array[5]  = 32'h0020C1B3;  // XOR rd=3, rs1=1, rs2=2
            instr_mem_array[6]  = 32'h0020A1B3;  // SLT rd=3, rs1=1, rs2=2
            instr_mem_array[7]  = 32'h0030A193;  // SLTI rd=3, rs1=1, imm=3
            instr_mem_array[8]  = 32'h002091B3;  // SLL rd=3, rs1=1, rs2=2
            instr_mem_array[9]  = 32'h00209193;  // SLLI rd=3, rs1=1, imm=2
            instr_mem_array[10] = 32'h001151B3;  // SRL rd=3, rs1=2, rs2=1
            instr_mem_array[11] = 32'h401151B3;  // SRA rd=3, rs1=2, rs2=1
            instr_mem_array[12] = 32'h00215193;  // SRLI rd=3, rs1=2, imm=2
            instr_mem_array[13] = 32'h40215193;  // SRAI rd=3, rs1=2, imm=2
            instr_mem_array[14] = 32'h0040C193;  // XORI rd=3, rs1=1, imm=4
            instr_mem_array[15] = 32'h0040F193;  // ANDI rd=3, rs1=1, imm=4
            instr_mem_array[16] = 32'h0040E193;  // ORI rd=3, rs1=1, imm=4
            instr_mem_array[17] = 32'h00520333;  // ADD rd=6, rs1=4, rs2=5
            instr_mem_array[18] = 32'h00527333;  // AND rd=6, rs1=4, rs2=5
            instr_mem_array[19] = 32'h00526333;  // OR rd=6, rs1=4, rs2=5
            instr_mem_array[20] = 32'h00524333;  // XOR rd=6, rs1=4, rs2=5
            instr_mem_array[21] = 32'h00522333;  // SLT rd=6, rs1=4, rs2=5
            instr_mem_array[22] = 32'h00523333;  // SLT rd=6, rs1=4, rs2=5
            instr_mem_array[23] = 32'hFFF22313;  // SLTI rd=6, rs1=4, imm=-1
            instr_mem_array[24] = 32'h00420303;  // LB rd=6, offset=4(rs1=4)
            instr_mem_array[25] = 32'h00421303;  // LH rd=6, offset=4(rs1=4)
            instr_mem_array[26] = 32'h00422303;  // LW rd=6, offset=4(rs1=4)
            instr_mem_array[27] = 32'h00424303;  // LBU rd=6, offset=4(rs1=4)
            instr_mem_array[28] = 32'h00425303;  // LHU rd=6, offset=4(rs1=4)
            instr_mem_array[29] = 32'h00238223;  // SB rs2=2, offset=4(rs1=7) - accessing mem_array[24]
            instr_mem_array[30] = 32'h00539423;  // SH rs2=5, offset=8(rs1=7) - accessing mem_array[28]
            instr_mem_array[31] = 32'h0053A623;  // SW rs2=5, offset=12(rs1=7) - accessing mem_array[32]
            //$display("Resetting all memory locations!");
        end else if (mem_write_enable && (mem_addr != 0)) begin
            //if (mem_read_enable) begin
                //mem_read_data <= mem_array[mem_addr >> 2]; // Assuming word-addressable memory
                //$display("Reading from memory address %h: %h", (mem_addr >> 2), mem_read_data);
            //end
            if (read_from_reg) begin
                //$display("Running %b Store Operation", store_operation);
                case(store_operation)
                    SB : data_mem_array[mem_addr >> 2] = data_from_reg[7:0];
                    SH : data_mem_array[mem_addr >> 2] = data_from_reg[15:0];
                    SW : data_mem_array[mem_addr >> 2] = data_from_reg;
                endcase
                //mem_array[mem_addr] <= mem_write_data; 
                //$display("Writing to memory address %h: %h", mem_addr, data_from_reg);
            end

            //$display("Time: %0t, mem_addr: %b, Mem Data : %b, data_from_reg: %h", 
            //$time, mem_addr, mem_read_data, data_from_reg);
        end
    end

endmodule
