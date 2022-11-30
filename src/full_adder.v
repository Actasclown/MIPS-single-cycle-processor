`include "../lib/xor_gate.v"
`include "../lib/and_gate.v"
`include "../lib/or_gate.v"

module full_adder(a, b, carry_in, carry_out, sum);

    input a, b, carry_in;
    output carry_out, sum;

    wire xor_a_b;
    wire and_a_b, and_carry_in;

    xor_gate xor_gate_a_b(.x(a), .y(b), .z(xor_a_b));
    xor_gate xor_gate_sum(.x(xor_a_b), .y(carry_in), .z(sum));
    
    and_gate and_gate_a_b(.x(a), .y(b), .z(and_a_b));
    and_gate and_gate_carry_in(.x(xor_a_b), .y(carry_in), .z(add_carry_in));
    or_gate or_gate_carry_out(.x(add_carry_in), .y(and_a_b), .z(carry_out));

endmodule
