`timescale 1ns/10ps
`include "../src/sub_32.v"

module sub_32_tb;

    reg [31:0] a, b;
    wire [31:0] difference;
    wire borrow, overflow;

    sub_32 sub_32_0(
        .a              (a),
        .b              (b),
        .difference     (difference),
        .borrow         (borrow),
        .overflow       (overflow)
    );

    initial begin
        $display("--------------------------sub_32---------------------------");
        $display("          a            b   difference     borrow  overflow");
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
        $display("------------------------------------------------------------");
        $finish;
    end

    always @(a, b) begin
        #5
        $display("%d  %d  %d          %b         %b",
            $signed(a), $signed(b), $signed(difference), borrow, overflow);
    end

endmodule
