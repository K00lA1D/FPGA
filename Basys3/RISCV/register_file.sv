module register_file(
    input logic clk,
    input logic reset,
    input logic [4:0] reg_read_addr1, // 1st reg address
    input logic [4:0] reg_read_addr2, // 2nd reg address
    input logic [4:0] reg_write_addr, // dest reg address
    input logic [31:0] reg_write_data, // data to write to dest reg
    input logic [2:0] load_operation, // LB, LH, LW, etc
    input logic reg_write_enable, // Writing to register?
    input logic reg_read_enable, // Reading from Register
    input logic read_from_mem, // Reading from memory?
    input logic [31:0] data_from_mem, // Data from memory address
    output logic [31:0] reg_read_data1,
    output logic [31:0] reg_read_data2
);

    logic [31:0] registers [0:31];

    localparam LB  = 3'b000; // Load Byte
    localparam LH  = 3'b001; // Load Halfword
    localparam LW  = 3'b010; // Load Word
    localparam LBU = 3'b100; // Load Byte Unsigned
    localparam LHU = 3'b101; // Load Halfword Unsigned

    assign reg_read_data1 = reg_read_addr1 ? registers[reg_read_addr1] : 32'b0;
    assign reg_read_data2 = reg_read_addr2 ? registers[reg_read_addr2] : 32'b0;


    always @(posedge clk or posedge reset) begin
        //$display("In Register - reg_write_enable: %b, reg_write_addr: %d", 
                //reg_write_enable, reg_write_addr);
        if (reset) begin
            integer i;
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] = 32'h00000000;
            end

            registers[1] = 32'h00000002;  // rs1
            registers[2] = 32'h00000007;  // rs2
            registers[4] = 32'h00000010;  // rs4
            registers[5] = 32'hFFFFFFF0;  // rs5
            registers[7] = 32'h00000014;  // rs7
            //$display("Resetting all registers");
        end else if (reg_write_enable && (reg_write_addr != 0)) begin
           
            if (read_from_mem) begin
                //$display("Running %b Load Operation", load_operation);
    
                case(load_operation)
                    LB  : registers[reg_write_addr] = {{24{data_from_mem[7]}}, data_from_mem[7:0]};
                    LH  : registers[reg_write_addr] = {{16{data_from_mem[15]}}, data_from_mem[15:0]};
                    LW  : registers[reg_write_addr] = data_from_mem;
                    LBU : registers[reg_write_addr] = {24'b0, data_from_mem[7:0]};
                    LHU : registers[reg_write_addr] = {16'b0, data_from_mem[15:0]};
                endcase
            end else begin
                //$display("Normal write operation");
                registers[reg_write_addr] = reg_write_data;
            end

            //$display("Time: %0t, Reg 1 Data:  %b, Reg 2 Data: %b, Mem Data : %b, Dest Reg Data: %h", 
            //$time, reg_read_data1, reg_read_data2, data_from_mem, registers[reg_write_addr]);
        end
    end

endmodule
