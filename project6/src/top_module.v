module top_module (
    input clk,
    input reset,
    input control,
    output [31:0] result
);

    wire [31:0] instruction;
    wire [2:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [15:0] imm;

    wire [31:0] reg_data1, reg_data2, alu_result;
    wire [31:0] imm_ext;

    wire beq_taken, is_jump;
    wire [4:0] jump_address;

    assign opcode = instruction[31:29];
    assign rs1    = instruction[28:24];
    assign rs2    = instruction[23:19];
    assign rd     = instruction[18:14];
    assign imm    = instruction[15:0];
    assign imm_ext = {{16{imm[15]}}, imm};

    wire [4:0] pc_jump_address = imm[4:0];

    assign beq_taken = (opcode == 3'b001) && (reg_data1 == reg_data2); // BEQ
    assign is_jump = (opcode == 3'b000); // JUMP

    instruction_decoder decoder (
        .clk(clk),
        .reset(reset),
        .control(control),
        .jump_addr(pc_jump_address),
        .pc_jump(is_jump || beq_taken),
        .instruction(instruction)
    );

    register_file rf (
        .clk(clk),
        .regWrite(!(opcode == 3'b000 || opcode == 3'b001)), // no write for JUMP or BEQ
        .readReg1(rs1),
        .readReg2(rs2),
        .writeReg(rd),
        .writeData(alu_result),
        .readData1(reg_data1),
        .readData2(reg_data2)
    );

    alu alu_core (
        .A(reg_data1),
        .B((opcode == 3'b110 || opcode == 3'b111) ? imm_ext : reg_data2),
        .aluOp(opcode),
        .result(alu_result)
    );

    assign result = alu_result;

endmodule

