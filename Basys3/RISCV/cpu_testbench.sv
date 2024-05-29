`timescale 1ns / 1ps

module cpu_testbench;

    logic clk;
    logic reset;
    // FPGA visuals
    logic [15:0] leds;
    logic [6:0] seg;
    logic [3:0] an;
    //logic seg_dp;

    top_module uut(
        .clk(clk),
        .btn_reset(reset),
        .leds(leds),
        .seg(seg),
        .an(an)
        //.seg_dp(seg_dp)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a 10MHz clock
    end

    /*initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a 100MHz clock
    end
    */

    initial begin
        $display("Starting simulation at time %0t", $time);
        
        // Simulate button bounce for a longer period
        reset = 0;
        #50 reset = 1;
        #50 reset = 0;
        #50 reset = 1; // Final Stable State

        #3000
        // Keep btn_reset stable for long enough to trigger debounce
        reset = 0;  // Release button after long stable state
        #3000
        //$display("Time: %0t, Button press simulated", $time);

        #2000000000;
        $finish;
    end

    always_ff @(posedge uut.clk_slow or posedge reset) begin
        if (reset) begin
            // Nothing to do on reset
        end else begin
            case (uut.instruction)
                32'h002081B3: begin  // ADD rd=3, rs1=1, rs2=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] + uut.register_file_inst.registers[2])) begin
                        $display("ADD instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] + uut.register_file_inst.registers[2], uut.register_file_inst.registers[3]);
                        $fatal("ADD instruction failed");
                    end
                end
                32'h00408193: begin  // ADDI rd=3, rs1=1, imm=4
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 4
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] + 4)) begin
                        $display("ADDI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] + 4, uut.register_file_inst.registers[3]);
                        $fatal("ADDI instruction failed");
                    end
                end
                32'h402081B3: begin  // SUB rd=3, rs1=1, rs2=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] - uut.register_file_inst.registers[2])) begin
                        $display("SUB instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] - uut.register_file_inst.registers[2], uut.register_file_inst.registers[3]);
                        $fatal("SUB instruction failed");
                    end
                end
                32'h0020F1B3: begin  // AND rd=3, rs1=1, rs2=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] & uut.register_file_inst.registers[2])) begin
                        $display("AND instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] & uut.register_file_inst.registers[2], uut.register_file_inst.registers[3]);
                        $fatal("AND instruction failed");
                    end
                end
                32'h0020E1B3: begin  // OR rd=3, rs1=1, rs2=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] | uut.register_file_inst.registers[2])) begin
                        $display("OR instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] | uut.register_file_inst.registers[2], uut.register_file_inst.registers[3]);
                        $fatal("OR instruction failed");
                    end
                end
                32'h0020C1B3: begin  // XOR rd=3, rs1=1, rs2=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] ^ uut.register_file_inst.registers[2])) begin
                        $display("XOR instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] ^ uut.register_file_inst.registers[2], uut.register_file_inst.registers[3]);
                        $fatal("XOR instruction failed");
                    end
                end
                32'h0020A1B3: begin  // SLT rd=3, rs1=1, rs2=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] < uut.register_file_inst.registers[2])) begin
                        $display("SLT instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] < uut.register_file_inst.registers[2], uut.register_file_inst.registers[3]);
                        $fatal("SLT instruction failed");
                    end
                end
                32'h0030A193: begin  // SLTI rd=3, rs1=1, imm=3
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 3
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] < 3)) begin
                        $display("SLTI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] < 3, uut.register_file_inst.registers[3]);
                        $fatal("SLTI instruction failed");
                    end
                end
                32'h002091B3: begin  // SLL rd=3, rs1=1, rs2=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] << uut.register_file_inst.registers[2][4:0])) begin
                        $display("SLL instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] << uut.register_file_inst.registers[2][4:0], uut.register_file_inst.registers[3]);
                        $fatal("SLL instruction failed");
                    end
                end
                32'h00209193: begin  // SLLI rd=3, rs1=1, imm=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 2
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] << 2)) begin
                        $display("SLLI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] << 2, uut.register_file_inst.registers[3]);
                        $fatal("SLLI instruction failed");
                    end
                end
                32'h001151B3: begin  // SRL rd=3, rs1=2, rs2=1
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[2] >> uut.register_file_inst.registers[1][4:0])) begin
                        $display("SRL instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[2] >> uut.register_file_inst.registers[1][4:0], uut.register_file_inst.registers[3]);
                        $fatal("SRL instruction failed");
                    end
                end
                32'h401151B3: begin  // SRA rd=3, rs1=2, rs2=1
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[2] >>> uut.register_file_inst.registers[1][4:0])) begin
                        $display("SRA instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[2] >>> uut.register_file_inst.registers[1][4:0], uut.register_file_inst.registers[3]);
                        $fatal("SRA instruction failed");
                    end
                end
                32'h00215193: begin  // SRLI rd=3, rs1=2, imm=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 2
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[2] >> 2)) begin
                        $display("SRLI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[2] >> 2, uut.register_file_inst.registers[3]);
                        $fatal("SRLI instruction failed");
                    end
                end
                32'h40215193: begin  // SRAI rd=3, rs1=2, imm=2
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 2
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[2] >>> 2)) begin
                        $display("SRAI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[2] >>> 2, uut.register_file_inst.registers[3]);
                        $fatal("SRAI instruction failed");
                    end
                end
                32'h0040C193: begin  // XORI rd=3, rs1=1, imm=4
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 4
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] ^ 4)) begin
                        $display("XORI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] ^ 4, uut.register_file_inst.registers[3]);
                        $fatal("XORI instruction failed");
                    end
                end
                32'h0040F193: begin  // ANDI rd=3, rs1=1, imm=4
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 4
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] & 4)) begin
                        $display("ANDI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] & 4, uut.register_file_inst.registers[3]);
                        $fatal("ANDI instruction failed");
                    end
                end
                32'h0040E193: begin  // ORI rd=3, rs1=1, imm=4
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = 4
                    if (uut.register_file_inst.registers[3] != (uut.register_file_inst.registers[1] | 4)) begin
                        $display("ORI instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[1] | 4, uut.register_file_inst.registers[3]);
                        $fatal("ORI instruction failed");
                    end
                end
                32'h00520333: begin  // ADD rd=6, rs1=4, rs2=5
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[6] != (uut.register_file_inst.registers[4] + uut.register_file_inst.registers[5])) begin
                        $display("ADD instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[4] + uut.register_file_inst.registers[5], uut.register_file_inst.registers[6]);
                        $fatal("ADD instruction failed");
                    end
                end
                32'h00527333: begin  // AND rd=6, rs1=4, rs2=5
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[6] != (uut.register_file_inst.registers[4] & uut.register_file_inst.registers[5])) begin
                        $display("AND instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[4] & uut.register_file_inst.registers[5], uut.register_file_inst.registers[6]);
                        $fatal("AND instruction failed");
                    end
                end
                32'h00526333: begin  // OR rd=6, rs1=4, rs2=5
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[6] != (uut.register_file_inst.registers[4] | uut.register_file_inst.registers[5])) begin
                        $display("OR instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[4] | uut.register_file_inst.registers[5], uut.register_file_inst.registers[6]);
                        $fatal("OR instruction failed");
                    end
                end
                32'h00524333: begin  // XOR rd=6, rs1=4, rs2=5
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[6] != (uut.register_file_inst.registers[4] ^ uut.register_file_inst.registers[5])) begin
                        $display("XOR instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[4] ^ uut.register_file_inst.registers[5], uut.register_file_inst.registers[6]);
                        $fatal("XOR instruction failed");
                    end
                end
                32'h00522333: begin  // SLT rd=6, rs1=4, rs2=5
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[6] != (($signed(uut.register_file_inst.registers[4]) < $signed(uut.register_file_inst.registers[5])) ? 32'd1 : 32'd0)) begin
                        $display("SLT instruction failed. Expected: %h, Got: %h", 
                                (($signed(uut.register_file_inst.registers[4]) < $signed(uut.register_file_inst.registers[5])) ? 32'd1 : 32'd0), uut.register_file_inst.registers[6]);
                        $fatal("SLT instruction failed");
                    end
                end

                32'h00523333: begin  // SLTU rd=6, rs1=4, rs2=5
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = X
                    if (uut.register_file_inst.registers[6] != (uut.register_file_inst.registers[4] < uut.register_file_inst.registers[5])) begin
                        $display("SLT instruction failed. Expected: %h, Got: %h", 
                                ((uut.register_file_inst.registers[4] < uut.register_file_inst.registers[5]) ? 32'd1 : 32'd0), uut.register_file_inst.registers[6]);
                        $fatal("SLT instruction failed");
                    end
                end
                32'hFFF22313: begin  // SLTI rd=6, rs1=4, imm=-1
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = -1
                    if (uut.register_file_inst.registers[6] != ($signed(uut.register_file_inst.registers[4]) < -1)) begin
                        $display("SLTI instruction failed. Expected: %h, Got: %h", 
                                $signed(uut.register_file_inst.registers[4]) < -1, uut.register_file_inst.registers[6]);
                        $fatal("SLTI instruction failed");
                    end
                end
                32'hFFF23313: begin  // SLTIU rd=6, rs1=4, imm=-1
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 0, immediate = -1
                    if (uut.register_file_inst.registers[6] != (uut.register_file_inst.registers[4] < -1)) begin
                        $display("SLTI instruction failed. Expected: %h, Got: %h", 
                                uut.register_file_inst.registers[4] < -1, uut.register_file_inst.registers[6]);
                        $fatal("SLTI instruction failed");
                    end
                end
                32'h00420303: begin  // LB rd=6, offset=4(rs1=4)
                // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 1, immediate = 4
                    if (uut.register_file_inst.registers[6] != {{24{uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][7]}}, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][7:0]}) begin
                        $display("LB instruction failed. Expected: %h, Got: %h", 
                                 {{24{uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][7]}}, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][7:0]}, uut.register_file_inst.registers[6]);
                        $fatal("LB instruction failed");
                    end
                end
                32'h00421303: begin  // LH rd=6, offset=4(rs1=4)
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 1, immediate = 4
                    if (uut.register_file_inst.registers[6] != {{16{uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][15]}}, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][15:0]}) begin
                        $display("LH instruction failed. Expected: %h, Got: %h", 
                                 {{16{uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][15]}}, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][15:0]}, uut.register_file_inst.registers[6]);
                        $fatal("LH instruction failed");
                    end
                end
                32'h00422303: begin  // LW rd=6, offset=4(rs1=4)
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 1, immediate = 4
                    if (uut.register_file_inst.registers[6] != uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4]) begin
                        $display("LW instruction failed. Expected: %h, Got: %h", 
                                 uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4], uut.register_file_inst.registers[6]);
                        $fatal("LW instruction failed");
                    end
                end
                32'h00424303: begin  // LBU rd=6, offset=4(rs1=4)
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 1, immediate = 4
                    if (uut.register_file_inst.registers[6] != {24'b0, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][7:0]}) begin
                        $display("LBU instruction failed. Expected: %h, Got: %h", 
                                 {24'b0, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][7:0]}, uut.register_file_inst.registers[6]);
                        $fatal("LBU instruction failed");
                    end
                end
                32'h00425303: begin  // LHU rd=6, offset=4(rs1=4)
                    // reg_write_enable = 1, reg_read_enable = 1, mem_write_enable = 0, mem_read_enable = 1, immediate = 4
                    if (uut.register_file_inst.registers[6] != {16'b0, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][15:0]}) begin
                        $display("LHU instruction failed. Expected: %h, Got: %h", 
                                 {16'b0, uut.memory_inst.data_mem_array[uut.register_file_inst.registers[4] + 4][15:0]}, uut.register_file_inst.registers[6]);
                        $fatal("LHU instruction failed");
                    end
                end
                32'h00238223: begin  // SB rs2=2, offset=4(rs1=7)
                    // reg_write_enable = 0, reg_read_enable = 1, mem_write_enable = 1, mem_read_enable = 0, immediate = 4
                    if (uut.memory_inst.data_mem_array[(uut.register_file_inst.registers[7] + 4) >> 2] != uut.register_file_inst.registers[2][7:0]) begin
                        $display("SB instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[2][7:0], uut.memory_inst.data_mem_array[(uut.register_file_inst.registers[7] + 4) >> 2]);
                        $fatal("SB instruction failed");
                    end
                end
                32'h00539423: begin  // SH rs2=5, offset=8(rs1=7)
                    // reg_write_enable = 0, reg_read_enable = 1, mem_write_enable = 1, mem_read_enable = 0, immediate = 8
                    if (uut.memory_inst.data_mem_array[(uut.register_file_inst.registers[7] + 8) >> 2] != uut.register_file_inst.registers[5][15:0]) begin
                        $display("SH instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[5][15:0], uut.memory_inst.data_mem_array[(uut.register_file_inst.registers[7] + 8) >> 2]);
                        $fatal("SH instruction failed");
                    end
                end
                32'h0053A623: begin  // SW rs2=5, offset=12(rs1=7)
                    // reg_write_enable = 0, reg_read_enable = 1, mem_write_enable = 1, mem_read_enable = 0, immediate = 12
                    if (uut.memory_inst.data_mem_array[(uut.register_file_inst.registers[7] + 12) >> 2] != uut.register_file_inst.registers[5]) begin
                        $display("SW instruction failed. Expected: %h, Got: %h", 
                                 uut.register_file_inst.registers[5], uut.memory_inst.data_mem_array[(uut.register_file_inst.registers[7] + 12) >> 2]);
                        $fatal("SW instruction failed");
                    end
                end
                default: begin
                    // Default case, no specific assertion
                end
            endcase
        end
    end

endmodule
