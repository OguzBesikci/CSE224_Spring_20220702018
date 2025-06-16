module instruction_decoder (
    input clk,
    input reset,
    input control,
    input [4:0] jump_addr,
    input pc_jump,
    output reg [31:0] instruction
);

    reg [4:0] pc;
    reg [31:0] instruction_memory [0:31];
    integer i;

    initial begin
        // Örnek Program (PDF'deki gibi)
        instruction_memory[0] = 32'b110_00000_01010_0000000000001010; // ADDI r10, r0, 10
        instruction_memory[1] = 32'b110_00000_01111_0000000000001111; // ADDI r15, r0, 15
        instruction_memory[2] = 32'b010_01010_01111_11001_00000000000; // ADD r25, r10, r15
        instruction_memory[3] = 32'b111_11001_10100_0000000000000101; // SUBI r20, r25, 5
        instruction_memory[4] = 32'b110_00000_10101_0000000000000010; // ADDI r21, r0, 2
        instruction_memory[5] = 32'b000_00000_00000_00000_0000000000001100; // J 12
        instruction_memory[6] = 32'b100_00111_10101_11110_00000000000; // SHIFTL r30, r7, r21 (atlanır)
        instruction_memory[12] = 32'b110_00000_00100_0000000000000100; // ADDI r4, r0, 4
        instruction_memory[13] = 32'b010_00000_00000_00101_00000000000; // ADD r5, r0, r0
        instruction_memory[14] = 32'b001_00100_00101_00000_0000000000000111; // BEQ r4, r5, 7
        instruction_memory[15] = 32'b110_00000_00110_0000000000000001; // ADDI r6, r0, 1
        instruction_memory[16] = 32'b110_00000_00111_0000000000000001; // ADDI r7, r0, 1
        instruction_memory[17] = 32'b010_00110_00111_01000_00000000000; // ADD r8, r6, r7
        instruction_memory[18] = 32'b010_00111_00000_00110_00000000000; // ADD r6, r7, r0
        instruction_memory[19] = 32'b010_01000_00000_00111_00000000000; // ADD r7, r8, r0
        instruction_memory[20] = 32'b110_00101_00101_0000000000000001; // ADDI r5, r5, 1
        instruction_memory[21] = 32'b000_00000_00000_00000_0000000000001110; // J 14

        for (i = 22; i < 32; i = i + 1)
            instruction_memory[i] = 32'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            instruction <= 32'b0;
        end else if (control) begin
            instruction <= instruction_memory[pc];

            if (pc_jump)
                pc <= jump_addr;
            else
                pc <= pc + 1;
        end
    end

endmodule

