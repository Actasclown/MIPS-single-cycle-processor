`timescale 1ns/10ps
`include "../src/add_32.v"

module add_32_tb;

    reg [31:0] a, b;
    reg carry_in;
    wire [31:0] sum;
    wire carry_out, overflow;

    add_32 add_32_0(
        .a              (a),
        .b              (b),
        .carry_in       (carry_in),
        .sum            (sum),
        .carry_out      (carry_out),
        .overflow       (overflow)
    );

    initial begin
        $display("------------------------------add_32-------------------------------");
        $display("          a            b  carry_in         sum  carry_out  overflow");
        #10
        a = 32'd2147483647;
        b = 32'd1;
        carry_in = 1'b0;

        #10
        a = 32'd2147483647;
        b = 32'd0;
        carry_in = 1'b1;

        #10
        a = 32'd2147483647;
        b = 32'd1;
        carry_in = 1'b1;

        #10
        a = 32'hffffffff;
        b = 32'h80000000;
        carry_in = 1'b0;

        #10
        a = 32'hf1233333;
        b = 32'h800000EF;
        carry_in = 1'b0;

        #10
        a = 32'h23;
        b = 32'h99;
        carry_in = 1'b1;

        #10
        a = 32'hfffffff3;
        b = 32'hffff0003;
        carry_in = 1'b0;

        #20
        $display("--------------------------------------------------------------------");
        $finish;
    end

    always @(a, b, carry_in) begin
        #5
        $display("%d  %d  %b        %d          %b         %b",
            $signed(a), $signed(b), carry_in, $signed(sum), carry_out, overflow);
    end

endmodule
