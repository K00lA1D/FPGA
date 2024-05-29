module display_mux (
    input logic clk,            // Fast clock for display update
    input logic reset,
    input logic [15:0] value,   // 16-bit value to display (program counter)
    output logic [3:0] an,      // Anode control
    output logic [6:0] seg      // Segment control
);
    logic [15:0] value_sync;    // Synchronized value

    // Synchronizer instance
    synchronizer sync_inst (
        .clk(clk),
        .reset(reset),
        .async_value(value),
        .sync_value(value_sync)
    );

    reg [1:0] digit_select;
    reg [3:0] hex_value;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            digit_select <= 0;
        end else begin
            digit_select <= digit_select + 1;
        end
    end

    always_comb begin
        case (digit_select)
            2'b00: begin
                an = 4'b1110;
                hex_value = value_sync[3:0];
            end
            2'b01: begin
                an = 4'b1101;
                hex_value = value_sync[7:4];
            end
            2'b10: begin
                an = 4'b1011;
                hex_value = value_sync[11:8];
            end
            2'b11: begin
                an = 4'b0111;
                hex_value = value_sync[15:12];
            end
            default: begin
                an = 4'b1111;
                hex_value = 4'b0000;
            end
        endcase
    end

    hex_to_7seg hex_to_7seg_inst (
        .hex(hex_value),
        .seg(seg)
    );
endmodule
