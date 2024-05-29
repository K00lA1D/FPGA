

module synchronizer(
    input logic clk,
    input logic reset,
    input logic [15:0] async_value,
    output logic [15:0] sync_value
);
    logic [15:0] sync_reg1;
    logic [15:0] sync_reg2;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sync_reg1 <= 16'b0;
            sync_reg2 <= 16'b0;
        end else begin
            sync_reg1 <= async_value;
            sync_reg2 <= sync_reg1;
        end
    end

    assign sync_value = sync_reg2;
endmodule