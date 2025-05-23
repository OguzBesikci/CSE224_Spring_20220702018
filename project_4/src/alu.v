module alu(
    input [31:0] inputA,
    input [31:0] inputB,
    input [1:0] opcode,
    output reg [31:0] result
);
    always @(*) begin
        case (opcode)
            2'b00: result = inputA + inputB;      
            2'b01: result = inputA - inputB;         
            2'b10: result = inputA << inputB;       
            2'b11: result = inputA >> inputB;        
            default: result = 32'b0;
        endcase
    end
endmodule 
