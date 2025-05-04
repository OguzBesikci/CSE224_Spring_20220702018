module ALU (
    input  [7:0] A,
    input  [7:0] B,
    input  [2:0] opcode,
    output reg [7:0] out
);

always @(*) begin
    case (opcode)
        3'b000: out = ~A;               // NOT
        3'b001: out = A | B;            // OR
        3'b010: out = A ^ B;            // XOR
        3'b011: out = A & B;            // AND
        3'b100: out = A[3:0] * B[3:0];  // 4x4 multiplier
        3'b101: out = A + B;            // 8-bit adder
        3'b110: out = A * B;            // 8-bit multiplier
        3'b111: out = A - B;            // 8-bit subtractor
        default: out = 8'b00000000;
    endcase
end

endmodule