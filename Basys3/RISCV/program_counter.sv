`timescale 1ns / 1ps

module program_counter(
    input wire clk,
    input wire reset,
    input wire [31:0] jump_addr,
    input wire jump,
    output reg [31:0] pc
);

    initial pc = 4'h0;

    always @(posedge clk or posedge reset)
    begin
        if (reset) begin
            $display("Resetting program counter");
            pc <= 4'h0;
        end else if (jump) begin
            pc <= jump_addr; 
        end else begin
            pc <= pc + 4; 
        end
        //$display("program_counter : %b", pc);
    end

endmodule