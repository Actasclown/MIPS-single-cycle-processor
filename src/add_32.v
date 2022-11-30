`include "../lib/xor_gate.v"
`include "../src/full_adder.v"

module add_32(a, b, carry_in, sum, carry_out, overflow);

    input [31:0] a, b;
    input carry_in;
    output [31:0] sum;
    output carry_out, overflow;

    wire [31:0] carry_outs;

    full_adder fall_adder_0(
        .a              (a[0]),
        .b              (b[0]),
        .carry_in       (carry_in),
        .sum            (sum[0]),
        .carry_out      (carry_outs[0])
    );

    genvar i;
    generate
        for(i = 1;i < 32;i = i + 1) begin
            full_adder fall_adder_0_31(
                .a              (a[i]),
                .b              (b[i]),
                .carry_in       (carry_outs[i - 1]),
                .sum            (sum[i]),
                .carry_out      (carry_outs[i])
            );
        end
    endgenerate

    assign carry_out = carry_outs[31];
    xor_gate xor_gate_overflow(.x(carry_outs[30]), .y(carry_outs[31]), .z(overflow));

endmodule
