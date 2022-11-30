`timescale 1ns/10ps
`include "../src/sltu_32.v"

module sltu_32_tb;

    reg [31:0] a, b;
    wire [31:0] rd;
    wire overflow;

    sltu_32 sltu_32_0(
        .rs(a),
        .rt(b),
        .rd(rd),
        .overflow(overflow)
    );

    initial begin
        $display("------------------sltu_32-------------------");
        $display("        rs          rt          rd  overflow");
        #10
        a = 32'h7fffffff;
        b = 32'hfffffff9;

        #10
        a = 32'h80000000;
        b = 32'h9;

        #10
        a = 32'hc;
        b = 32'hfffffff9;

        #10
        a = 32'ha;
        b = 32'h4;

        #10
        a = 32'hfffffff3;
        b = 32'hfffffff9;

        #10
        a = 32'hfffffff3;
        b = 32'hfffffff3;

        #10
        a = 32'hfffffff3;
        b = 32'hffff0003;

        #20
        $display("--------------------------------------------");
        $finish;
    end

    always @(a, b) begin
        #5
        $display("%d  %d  %d         %b",
            a, b, rd, overflow);
    end

endmodule
