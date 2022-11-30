`include "../src/add_32.v"
`include "../lib/not_gate_32.v"
`include "../lib/not_gate.v"

module sub_32(a, b, difference, borrow, overflow);

    input [31:0] a, b;
    output [31:0] difference;
    output borrow, overflow;

    wire [31:0] minus_b;
    wire carry_out;

    not_gate_32 not_gate_32_b(.x(b), .z(minus_b));
    add_32 add_32_minus_b_add_1(
        .a(a),
        .b(minus_b),
        .carry_in(1'b1),
        .sum(difference),
        .carry_out(carry_out),
        .overflow(overflow)
    );
    not_gate not_gate_carry_out(.x(carry_out), .z(borrow));

endmodule
