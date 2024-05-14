module mux2x1(
    input wire input_1,  
    input wire input_2,   
    input wire select_line, 
    output wire output_led  
);

    assign output_led = (select_line) ? input_2 : input_1;

endmodule