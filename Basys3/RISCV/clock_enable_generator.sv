



module clock_enable_generator(
    input logic clk_in,
    input logic rst,
    output logic clk_enable
);
    logic [28:0] clk_div = 0;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            clk_div = 0;
            clk_enable = 0;
            //$display("Time: %0t, clk_div reset to 0", $time);
        end else begin
            clk_div = clk_div + 1;
            if (clk_div == 0) begin
                //clk_enable = 1;
                clk_enable = ~clk_enable;
                //$display("Time: %0t, clk_enable toggled to: %b", $time, clk_enable);
            end
            //end else begin
                //clk_enable = 0;
                //$display("Time: %0t, clk_div incremented to: %0d", $time, clk_div);
            //end
        end
    end

endmodule

