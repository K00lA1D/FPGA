module counter_8bit(
    input wire clk, 
    input wire rst, 
    output reg [7:0] out
);

reg [22:0] clk_div;  
wire slow_clk = clk_div[22]; 

always @(posedge clk or posedge rst) begin
    if (rst)
        clk_div <= 0;
    else
        clk_div <= clk_div + 1;
end

always @(posedge slow_clk or posedge rst) begin
    if (rst)
        out <= 0;
    else if (out == 8'hFF)
        out <= 0;
    else
        out <= out + 1;
end

endmodule
