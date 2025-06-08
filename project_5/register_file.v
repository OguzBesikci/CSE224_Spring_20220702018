module register_file (
    input clk,
    input regWrite,
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    output reg [31:0] readData1,
    output reg [31:0] readData2
);

    reg [31:0] registers [0:31];

    always @(posedge clk) begin
        if (regWrite && writeReg != 0)
            registers[writeReg] <= writeData;
    end

    always @(*) begin
        readData1 = (readReg1 == 0) ? 32'b0 : registers[readReg1];
        readData2 = (readReg2 == 0) ? 32'b0 : registers[readReg2];
    end

endmodule

