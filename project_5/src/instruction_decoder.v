module instruction_decoder (
    input clk,
    input reset,
    input control,
    output reg [31:0] instruction
);

    reg [4:0] pc; 
    reg [31:0] instruction_memory [0:31];
    integer i;


    initial begin
        instruction_memory[0] = 32'b110_00000_01010_0000000000001010;
        instruction_memory[1] = 32'b110_00000_01111_0000000000001111;
        instruction_memory[2] = 32'b010_01010_01111_11001_00000000000;
        instruction_memory[3] = 32'b111_11001_10100_0000000000000101;
        instruction_memory[4] = 32'b110_00000_00101_0000000000000010; 
        instruction_memory[5] = 32'b100_11001_00101_11110_00000000000;

        for (i = 6; i < 32; i = i + 1) begin
            instruction_memory[i] = 32'b0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            instruction <= 32'b0;
        end else if (control) begin
            instruction <= instruction_memory[pc];
            pc <= pc + 1;
        end else begin
            instruction <= 32'b0;  
        end
    end

endmodule

