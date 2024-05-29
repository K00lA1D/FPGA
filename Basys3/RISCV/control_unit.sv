module control_unit(
    input logic [31:0] instruction,
    output logic [4:0] alu_op,
    output logic mem_read_enable,
    output logic mem_write_enable,
    output logic reg_read_enable,
    output logic reg_write_enable,
    output logic [4:0] reg_write_addr,
    output logic [4:0] reg_read_addr1,
    output logic [4:0] reg_read_addr2,
    output logic [11:0] immediate,
    output logic [2:0] load_operation,
    output logic [2:0] store_operation,
    output logic jump
);

    localparam R_TYPE = 7'b0110011;
    localparam I_TYPE = 7'b0010011;
    localparam LOAD   = 7'b0000011;
    localparam STORE  = 7'b0100011;

    //R-Type Operations
    localparam ADD_SUB  = 3'b000; // Add or Subtract
    localparam SLL  = 3'b001; // Logical Shift Left
    localparam SLT  = 3'b010; // Set Less Than
    localparam SLTU = 3'b011; // Set Less Than Unsigned
    localparam XOR  = 3'b100; // XOR bitwise
    localparam SR   = 3'b101; // Shift Right (Logical/Arithmetic)
    localparam OR   = 3'b110; // OR bitwise
    localparam AND  = 3'b111; // AND bitwise

    //I-Type Operations
    localparam ADDI  = 3'b000; // ADD
    localparam SLLI  = 3'b001; // Logical Shift Left
    localparam SLTI  = 3'b010; // Set less than (signed)
    localparam SLTUI = 3'b011; // Set less than (unsigned)
    localparam XORI  = 3'b100; // XOR bitwise
    localparam SRI  = 3'b101; // Shift Right (Logical/Arithmetic)
    localparam ORI   = 3'b110; // OR bitwise
    localparam ANDI  = 3'b111; // AND bitwise

    always_comb begin

        immediate = 12'bxxxxxxxxxxxx;
        alu_op = 5'bxxxxx;
        load_operation = 3'bxxx;
        store_operation = 3'bxxx;
        mem_read_enable = 0;
        mem_write_enable = 0;
        reg_read_enable = 0;
        reg_write_enable = 0;
        jump = 0;
        reg_write_addr = instruction[11:7]; //destination register
        reg_read_addr1 = instruction[19:15]; //source reg 1
        reg_read_addr2 = 5'bxxxxxx; //source reg 2
        
        //$display("Processing has started");
        if (instruction != 32'b0) begin

            case (instruction[6:0])
                R_TYPE: begin
                    reg_read_addr2 = instruction[24:20]; //source reg 2
                    reg_read_enable = 1;
                    reg_write_enable = 1;
                    case (instruction[14:12]) 
                        ADD_SUB: alu_op = (instruction[30] ? 5'b00001 : 5'b00000); // ADD/SUB
                        SLL  : alu_op = 5'b00010;
                        SLT  : alu_op = 5'b00011;
                        SLTU : alu_op = 5'b00100;
                        XOR  : alu_op = 5'b00101;
                        SR   : alu_op = (instruction[30] ? 5'b00111 : 5'b00110); // SRA/SRL
                        OR   : alu_op = 5'b01000;
                        AND  : alu_op = 5'b01001;
                    endcase
                end
                I_TYPE: begin 
                    immediate = instruction[31:20];
                    reg_read_enable = 1;
                    reg_write_enable = 1;
                    case (instruction[14:12])
                        ADDI : alu_op = 5'b01010;
                        SLLI : alu_op = 5'b01011;
                        SLTI : alu_op = 5'b01100;
                        SLTUI: alu_op = 5'b01101;
                        XORI : alu_op = 5'b01110;
                        SRI : begin
                            immediate = instruction[24:20]; //modified immediate parsing for this case
                            alu_op = (instruction[30] ? 5'b10000 : 5'b01111); // SRLI/SRAI
                        end
                        ORI  : alu_op = 5'b10001;
                        ANDI : alu_op = 5'b10010;
                    endcase
                end
                LOAD: begin // Load instructions
                    mem_read_enable = 1;
                    immediate = instruction[31:20];
                    load_operation = instruction[14:12];
                    alu_op = 5'b01010; // ADD operation for calculating address
                    reg_write_enable = 1;
                end
                STORE: begin // Store instructions
                    immediate = {instruction[31:25], instruction[11:7]};
                    store_operation = instruction[14:12];
                    reg_read_addr2 = instruction[24:20]; //source reg 2
                    reg_read_enable = 1;
                    mem_write_enable = 1;
                    alu_op = 5'b01010; // ADD operation for calculating address
                end
                7'b1101111: begin // Jump
                    jump = 1;
                    reg_write_enable = 1;
                end
            endcase
        end

        //$display("Time: %0t, Instruction: %h, Opcode: %b, funct3: %b, funct7: %b, ALU Op: %b, Mem Read Enable: %b, Mem Write Enable: %b, Reg Write Enable: %b, Dest Reg: %0d, Reg 1: %0d, Reg 2: %0d, Jump: %b", 
                 //$time, instruction, instruction[6:0], instruction[14:12], 
                 //instruction[31:25], alu_op, mem_read_enable, mem_write_enable, 
                 //reg_write_enable, reg_write_addr, reg_read_addr1, 
                 //reg_read_addr2, jump);
    end

endmodule
