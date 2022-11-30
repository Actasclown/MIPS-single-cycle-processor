`include "../lib/mux_32.v"

module srl_32(rt, shamt, rd);
    input [31:0] rt;
    input [4:0] shamt;
    output [31:0] rd;

    wire [31:0] temp_0, temp_1, temp_2, temp_3;

    mux_32 mux_32_1(
        .sel({31'b0, shamt[0]}),
        .src0(rt),
        .src1({1'b0, rt[31:1]}),
        .z(temp_0)
    );

    mux_32 mux_32_2(
        .sel({31'b0, shamt[1]}),
        .src0(temp_0),
        .src1({2'b0, temp_0[31:2]}),
        .z(temp_1)
    );

    mux_32 mux_32_4(
        .sel({31'b0, shamt[2]}),
        .src0(temp_1),
        .src1({4'b0, temp_1[31:4]}),
        .z(temp_2)
    );

    mux_32 mux_32_8(
        .sel({31'b0, shamt[3]}),
        .src0(temp_2),
        .src1({8'b0, temp_2[31:8]}),
        .z(temp_3)
    );

    mux_32 mux_32_16(
        .sel({31'b0, shamt[4]}),
        .src0(temp_3),
        .src1({16'b0, temp_3[31:16]}),
        .z(rd)
    );

endmodule
