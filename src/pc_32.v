`include "../src/add_32.v"
`include "../lib/mux_32.v"
`include "../src/pc_head_32.v"
`include "../src/signext_32.v"
`include "../lib/and_gate.v"


module pc_32(branch, zero, addr, jump, clk, reset, instruction);


input branch;
input zero;
input [31:0] instruction;
input jump;
input clk;
input reset;

output [31:0] addr;

// wire [31:0] w0, [31:0] w1, [31:0] w2, [31:0] w3, [31:0] w4, [31:0] w5;
wire [31:0] w0, w1, w2, w3, w4, w5;
wire w6;
wire w7, w8, w9; //don't care module outputs



pc_head_32 pc_head_32_0(
    .clk(clk),
    .addr(w0),
    .reset(reset),
    .new_addr(w1)
);

mux_32 mux_32_0 (
    .src0(w5),
    .src1({w1[31:28], instruction[25:0], 2'b0}),
    .sel({31'b0, jump}),
    .z(w0)
);

add_32 add_32_0(
    .a(w1),
    .b(32'h00000004),
    .sum(w2),
    .carry_in(1'b0),
    .carry_out(w7)
);

signext_32 signext_32_0(
    .imm(instruction[15:0]),
    .extended(w3)
);

add_32 add_32_1(
    .a(w2),
    .b(w3),
    .sum(w4),
    .carry_in(1'b0),
    .carry_out(w8)
);

mux_32 mux_32_1(
    .src0(w2),
    .sel({31'b0, w6}),
    .src1(w4),
    .z(w5)
);

and_gate and_gate_0(
    .x(barnch),
    .y(zero),
    .z(w6)
);


assign addr = w1;


endmodule