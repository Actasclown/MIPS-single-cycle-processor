`timescale 1ns/10ps
`include "../src/zero_32.v"

module zero_32_tb;
    reg [31:0] source;
    wire [31:0] result;

    zero_32 zero_32_0(
        .source(source),
        .result(result)
    );

    initial begin
        #10
        $display("-------zero_32--------");
        $display("source          result");

        #10
        source = 32'hfad21321;

        #10
        source = 32'h0;

        #10
        source = 32'h1;

        #10
        source = 32'h80000000;

        #20
        $display("----------------------");
        $finish;
    end

    always @(source) begin
        #5
        $display("%h    %d", source, result);
    end

endmodule
