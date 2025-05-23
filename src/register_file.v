module register_file(
    input clk,
    input we3,
    input [4:0] a1, a2, a3,
    input [31:0] wd3,
    output [31:0] rd1, rd2
);
    reg [31:0] regfile [31:0];

    assign rd1 = regfile[a1];
    assign rd2 = regfile[a2];

    always @(posedge clk) begin
        if (we3)
            regfile[a3] <= wd3;
    end
endmodule 
