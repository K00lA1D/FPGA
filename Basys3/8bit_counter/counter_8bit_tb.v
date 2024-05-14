`timescale 1ns / 1ps

module counter_8bit_tb;

    reg clk;
    reg rst;
    wire [7:0] out;

    counter_8bit uut(
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    initial clk = 0;
    always #5 clk = ~clk;  

    initial begin
        rst = 1; 
        #100;    
        rst = 0;  

        #200; 
        $display("Test complete");
        $finish;
    end

endmodule