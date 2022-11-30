
`include "../lib/mux_32.v"
`include "../lib/mux.v"
`include "../lib/and_gate_32.v"
`include "../lib/or_gate_32.v"
`include "../lib/xor_gate_32.v"

`include "../src/zero_32.v"
`include "../src/sll_32.v"
`include "../src/srl_32.v"
`include "../src/add_32.v"
`include "../src/sub_32.v"
`include "../src/slt_32.v"
`include "../src/sltu_32.v"
`include "../src/mux8_1_32.v"

// control table:
// rt, shamt, rd => result
// 0 000 sll
// 0 010 srl
// a, b => result, carry_out, overflow
// 1 000 add
// 1 010 sub
// a, b => result, overflow
// 1 001 slt
// 1 011 sltu
// a, b => result
// 1 100 and
// 1 101 or
// 1 110 xor

module alu_32(a, b, control, shamt, result, carry_out, overflow, zero);
    input [31:0] a, b;
    input [3:0] control;
    input [4:0] shamt;
    output wire [31:0] result;
    output carry_out, overflow, zero;

    wire [31:0] sll_result;
    wire [31:0] srl_result;
    sll_32 sll_32_0(
        .rt(b),
        .shamt(shamt),
        .rd(sll_result)
    );
    srl_32 srl_32_0(
        .rt(b),
        .shamt(shamt),
        .rd(srl_result)
    );

    wire [31:0] add_result, sub_result;
    wire add_carry_out, sub_carry_out;
    wire add_overflow, sub_overflow;
    add_32 add_32_0(
        .a              (a),
        .b              (b),
        .carry_in       (1'b0),
        .sum            (add_result),
        .carry_out      (add_carry_out),
        .overflow       (add_overflow)
    );
    sub_32 sub_32_0(
        .a              (a),
        .b              (b),
        .difference     (sub_result),
        .borrow         (sub_carry_out),
        .overflow       (sub_overflow)
    );

    wire [31:0] slt_result, sltu_result;
    wire slt_overflow, sltu_overflow;
    slt_32 slt_32_0(
        .rs(a),
        .rt(b),
        .rd(slt_result),
        .overflow(slt_overflow)
    );
    sltu_32 sltu_32_0(
        .rs(a),
        .rt(b),
        .rd(sltu_result),
        .overflow(sltu_overflow)
    );

    wire [31:0] and_result, or_result, xor_result;
    and_gate_32 and_gate_32_0   (.x(a),.y(b),.z(and_result));
    or_gate_32 or_gate_32_0     (.x(a),.y(b),.z(or_result));
    xor_gate_32 xor_gate_32_0   (.x(a),.y(b),.z(xor_result));

//---------------------------control logic---------------------------

    wire [31:0] shift_result;
    mux8_1_32 mux8_1_32_shift_result(
        .select(control[2:0]),
        .s_000(sll_result),
        .s_001(32'b0),
        .s_010(srl_result),
        .s_011(32'b0),
        .s_100(32'b0),
        .s_101(32'b0),
        .s_110(32'b0),
        .s_111(32'b0),
        .result(shift_result)
    );
    wire [31:0] non_shift_result;
    mux8_1_32 mux8_1_32_non_shift_result(
        .select(control[2:0]),
        .s_000(add_result),
        .s_001(slt_result),
        .s_010(sub_result),
        .s_011(sltu_result),
        .s_100(and_result),
        .s_101(or_result),
        .s_110(xor_result),
        .s_111(32'b0),
        .result(non_shift_result)
    );
    mux_32 mux_32_result(
        .sel({31'b0, control[3]}),
        .src0(shift_result),
        .src1(non_shift_result),
        .z(result)
    );

    wire non_shift_carry_out;
    mux8_1 mux8_1_carry_out (
        .select(control[2:0]),
        .s_000(add_carry_out),
        .s_001(1'b0),
        .s_010(sub_carry_out),
        .s_011(1'b0),
        .s_100(1'b0),
        .s_101(1'b0),
        .s_110(1'b0),
        .s_111(1'b0),
        .result(non_shift_carry_out)
    );
    mux mux_carry_out(
        .sel(control[3]),
        .src0(1'b0),
        .src1(non_shift_carry_out),
        .z(carry_out)
    );

    wire non_shift_overflow;
    mux8_1 mux8_1_overflow (
        .select(control[2:0]),
        .s_000(add_overflow),
        .s_001(slt_overflow),
        .s_010(sub_overflow),
        .s_011(sltu_overflow),
        .s_100(1'b0),
        .s_101(1'b0),
        .s_110(1'b0),
        .s_111(1'b0),
        .result(non_shift_overflow)
    );
    mux mux_overflow(
        .sel(control[3]),
        .src0(1'b0),
        .src1(non_shift_overflow),
        .z(overflow)
    );

    zero_32 zero_32_0(.source(result), .result(zero));

endmodule
