`include "../src/sub_32.v"
`include "../lib/xor_gate.v"

module slt_32(rs, rt, rd, overflow);
    input [31:0] rs, rt;
    output [31:0] rd;
    output overflow;

    wire borrow, same_msb;
    //wire slts_temp;

    assign rd[31:1] = 31'b0;

    sub_32 sub_32_0(
        .a(rs),
        .b(rt),
        .borrow(borrow),
        .overflow(overflow)
    );

    xor_gate xor_gate_msb(.x(rs[31]), .y(rt[31]), .z(same_msb));
    xor_gate xor_gate_borrow(.x(same_msb), .y(borrow), .z(rd[0]));
    //xor_gate xor0_map(.x(borrow), .y(overflow), .z(slts_temp));
    //xor_gate xor_gate_borrow(.x(same_msb), .y(slts_temp), .z(rd[0]));

endmodule
