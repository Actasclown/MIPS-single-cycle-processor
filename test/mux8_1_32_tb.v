`timescale 1ns/10ps
`include "../src/mux8_1_32.v"

module mux8_1_32_tb;

    reg [2:0] select;
    reg [31:0] s_000, s_001, s_010, s_011, s_100, s_101, s_110, s_111;
    wire [31:0] result;

    mux8_1_32 mux8_1_32_0(
        .select(select),
        .s_000(s_000),
        .s_001(s_001),
        .s_010(s_010),
        .s_011(s_011),
        .s_100(s_100),
        .s_101(s_101),
        .s_110(s_110),
        .s_111(s_111),
        .result(result)
    );

    initial begin
        #10
        s_000 = 32'd1;
        s_001 = 32'd2;
        s_010 = 32'd3;
        s_011 = 32'd4;
        s_100 = 32'h65465666;
        s_101 = 32'd6;
        s_110 = 32'd7;
        s_111 = 32'hfffffffa;

        #10
        $display("----mux8_1_32-----");
        $display("select      result");

        #10
        select = 3'd0;

        #10
        select = 3'd1;

        #10
        select = 3'd2;

        #10
        select = 3'd3;

        #10
        select = 3'd4;

        #10
        select = 3'd5;

        #10
        select = 3'd6;

        #10
        select = 3'd7;

        #20
        $display("-------------------");
        $finish;
    end

    always @(select) begin
        #5
        $display("   %d   %d", select, $signed(result));
    end

endmodule
