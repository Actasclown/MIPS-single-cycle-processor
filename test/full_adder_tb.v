`timescale 1ns/10ps
`include "../src/full_adder.v"

module full_adder_32_tb;

    reg a, b, carry_in;
    wire sum, carry_out, overflow;

    full_adder fall_adder_0(
        .a              (a),
        .b              (b),
        .carry_in       (carry_in),
        .sum            (sum),
        .carry_out      (carry_out)
    );

    initial begin
        $display("----------full_adder----------");
        $display("a  b  carry_in  sum  carry_out");
        #10
        a = 1'b0;
        b = 1'b0;
        carry_in = 1'b0;

        #10
        a = 1'b0;
        b = 1'b0;
        carry_in = 1'b1;

        #10
        a = 1'b0;
        b = 1'b1;
        carry_in = 1'b0;

        #10
        a = 1'b0;
        b = 1'b1;
        carry_in = 1'b1;

        #10
        a = 1'b1;
        b = 1'b0;
        carry_in = 1'b0;

        #10
        a = 1'b1;
        b = 1'b0;
        carry_in = 1'b1;

        #10
        a = 1'b1;
        b = 1'b1;
        carry_in = 1'b0;

        #10
        a = 1'b1;
        b = 1'b1;
        carry_in = 1'b1;

        #20
        $display("------------------------------");
        $finish;
    end

    always @(a, b, carry_in) begin
        #5
        $display("%b  %b      %b      %b           %b", a, b, carry_in, sum, carry_out);
    end

endmodule
