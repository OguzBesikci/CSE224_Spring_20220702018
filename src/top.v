module top(
    input clk,
    input we3,
    input [4:0] a1, a2, a3,
    input [31:0] wd3,
    input [31:0] inputA, inputB,
    input [1:0] opcode,
    output [31:0] rd1, rd2, alu_result
);
    wire [31:0] reg_rd1, reg_rd2;

    register_file rf(
        .clk(clk),
        .we3(we3),
        .a1(a1), .a2(a2), .a3(a3),
        .wd3(wd3),
        .rd1(reg_rd1),
        .rd2(reg_rd2)
    );

    alu alu_unit(
        .inputA(inputA),
        .inputB(inputB),
        .opcode(opcode),
        .result(alu_result)
    );

    assign rd1 = reg_rd1;
    assign rd2 = reg_rd2;
endmodule

