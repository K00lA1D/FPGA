module debounce(
    input logic clk,
    input logic btn,
    output logic btn_clean
);

    logic [7:0] count = 0;
    logic btn_sync = 0;
    logic btn_stable = 0;

    always @(posedge clk) begin

        btn_sync = btn;
        if (btn_sync == btn_stable) begin
            if (count < 8'hFF) begin
                count = count + 1;
            end else begin
                btn_clean = btn_sync;
            end

        end else begin 
            count = 0;
            btn_stable = btn_sync;
        end
    end
endmodule
