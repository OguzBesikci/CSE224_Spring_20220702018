module alu (
    input [31:0] A,
    input [31:0] B,
    input [2:0] aluOp,
    output reg [31:0] result
);

    always @(*) begin
        case (aluOp)
            3'b000: result = 32'b0;         // JUMP (not used here)
            3'b001: result = 32'b0;         // BEQ (not used here)
            3'b010: result = A + B;         // ADD
            3'b011: result = A - B;         // SUB
            3'b100: result = A << B;        // SHIFTL
            3'b101: result = A >> B;        // SHIFTR
            3'b110: result = A + B;         // ADDI
            3'b111: result = A - B;         // SUBI
            default: result = 32'b0;
        endcase
    end

endmodule

