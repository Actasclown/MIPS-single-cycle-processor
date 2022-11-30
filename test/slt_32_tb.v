`timescale 1ns/10ps
`include "../src/slt_32.v"

module slt_32_tb;

    reg [31:0] a, b;
    wire [31:0] rd;
    wire overflow;

    slt_32 slt_32_0(
        .rs(a),
        .rt(b),
        .rd(rd),
        .overflow(overflow)
    );

    initial begin
        $display("-----------------------slt_32------------------------");
        $display("         rs           rt          rd         overflow");
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
        a = 32'hfffffff9;
        b = 32'hc;

        #10
        a = 32'h7fffffff;
        b = 32'h1;

        #10
        a = 32'h1;
        b = 32'h7fffffff;

        #10
        a = 32'hfffffff3;
        b = 32'hffff0003;

        #10
        a = 32'hffff0003;
        b = 32'hfffffff3;

        #10
        a = 32'h2;
        b = 32'hfffffffa;

        #10
        a = 32'h2;
        b = 32'h2;

        #10
        a = 32'hfffffffa;
        b = 32'hfffffffb;

        #10
        a = 32'hfffffffa;
        b = 32'hfffffff0;

        #20
        $display("------------------------------------------------------");
        $finish;
    end

    always @(a, b) begin
        #5
        $display("%d  %d  %d                %b",
            $signed(a), $signed(b), rd, overflow);
    end

endmodule
