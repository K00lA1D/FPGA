module alu(
    input logic [31:0] operand_a,
    input logic [31:0] operand_b,
    input logic [11:0] immediate, // 12-bit immediate value
    input logic [4:0] op_code,    // Increased to 5 bits to handle more opcodes
    output logic [31:0] result,
    output logic zero
);

    //R-Type Operations
    localparam ADD  = 5'b00000; // Add
    localparam SUB  = 5'b00001; // Subtract
    localparam SLL  = 5'b00010; // Logical Shift Left
    localparam SLT  = 5'b00011; // Set Less Than
    localparam SLTU = 5'b00100; // Set Less Than Unsigned
    localparam XOR  = 5'b00101; // XOR bitwise
    localparam SRL  = 5'b00110; // Shift Right Logical
    localparam SRA  = 5'b00111; // Shift Right Arithmetic
    localparam OR   = 5'b01000; // OR bitwise
    localparam AND  = 5'b01001; // AND bitwise

    //I-Type Operations
    localparam ADDI  = 5'b01010; // ADD
    localparam SLLI  = 5'b01011; // Logical Shift Left
    localparam SLTI  = 5'b01100; // Set less than (signed)
    localparam SLTUI = 5'b01101; // Set less than (unsigned)
    localparam XORI  = 5'b01110; // XOR bitwise
    localparam SRLI  = 5'b01111; // Logical Shift Right
    localparam SRAI  = 5'b10000; // Arithmetic Shift Right
    localparam ORI   = 5'b10001; // OR bitwise
    localparam ANDI  = 5'b10010; // AND bitwise

    // Sign-extend the immediate value to 32 bits
    logic [31:0] immediate_extended;
    assign immediate_extended = {{20{immediate[11]}}, immediate};  // Sign-extension

     always_comb begin
        case (op_code)
            // R-Type Operations
            ADD:  result = operand_a + operand_b;
            SUB:  result = operand_a - operand_b;
            SLL:  result = operand_a << operand_b[4:0];
            SLT:  result = ($signed(operand_a) < $signed(operand_b)) ? 32'd1 : 32'd0;
            SLTU: result = (operand_a < operand_b) ? 32'd1 : 32'd0; // Unsigned comparison
            XOR:  result = operand_a ^ operand_b;
            SRL:  result = operand_a >> operand_b[4:0];
            SRA:  result = $signed(operand_a) >>> operand_b[4:0]; // Arithmetic right shift
            OR:   result = operand_a | operand_b;
            AND:  result = operand_a & operand_b;

            // I-Type Operations
            ADDI: result = operand_a + immediate_extended;
            SLLI: result = operand_a << immediate_extended[4:0];
            SLTI: result = ($signed(operand_a) < $signed(immediate_extended)) ? 32'd1 : 32'd0;
            SLTUI:result = (operand_a < immediate_extended) ? 32'd1 : 32'd0;
            XORI: result = operand_a ^ immediate_extended;
            SRLI: result = operand_a >> immediate_extended[4:0];
            SRAI: result = $signed(operand_a) >>> immediate_extended[4:0]; // Arithmetic right shift with immediate
            ORI:  result = operand_a | immediate_extended;
            ANDI: result = operand_a & immediate_extended;

            default: result = 32'd0;
        endcase
        //$display("Time: %0t, ALU Operation: %b, Operand A: %h, Operand B: %h, Immediate: %h, Result: %h", $time, op_code, operand_a, operand_b, immediate, result);
    end

    assign zero = (result == 32'd0);

endmodule
