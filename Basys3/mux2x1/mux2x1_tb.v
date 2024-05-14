`timescale 1ns / 1ps

module mux2x1_tb;

    reg input_1;
    reg input_2;
    reg select_line;
    wire output_led;

    mux2x1 uut(
        .input_1(input_1), 
        .input_2(input_2), 
        .select_line(select_line), 
        .output_led(output_led)
    );

    initial begin
        input_1 = 0;
        input_2 = 0;
        select_line = 0;

        #10;
        input_1 = 1;
        input_2 = 0;
        select_line = 0;
        #10;

        input_1 = 0;
        input_2 = 1;
        select_line = 1;
        #10;

        input_1 = 1;
        input_2 = 0;
        select_line = 1;
        #10;

        select_line = 0;
        #10;

        $display("Test complete");
        $finish;
    end

endmodule