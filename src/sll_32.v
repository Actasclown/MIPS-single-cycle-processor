//`include "../src/mux32_1.v"
`include "../lib/mux_32.v"

module sll_32(rt, shamt, rd);
    input [31:0] rt;
    input [4:0] shamt;
    output [31:0] rd;

    wire [31:0] temp_0, temp_1, temp_2, temp_3;

    mux_32 mux_32_1(
        .sel({31'b0, shamt[0]}),
        .src0(rt),
        .src1({rt[30:0], 1'b0}),
        .z(temp_0)
    );

    mux_32 mux_32_2(
        .sel({31'b0, shamt[1]}),
        .src0(temp_0),
        .src1({temp_0[29:0], 2'b0}),
        .z(temp_1)
    );

    mux_32 mux_32_4(
        .sel({31'b0, shamt[2]}),
        .src0(temp_1),
        .src1({temp_1[27:0], 4'b0}),
        .z(temp_2)
    );

    mux_32 mux_32_8(
        .sel({31'b0, shamt[3]}),
        .src0(temp_2),
        .src1({temp_2[23:0], 8'b0}),
        .z(temp_3)
    );

    mux_32 mux_32_16(
        .sel({31'b0, shamt[4]}),
        .src0(temp_3),
        .src1({temp_3[15:0], 16'b0}),
        .z(rd)
    );

    // wire [31:0] temp;
    // wire [31:0] zero;

    // assign zero = 32'h0;
    //
    // assign temp[0] = rt[0];
    // assign temp[31:1] = zero[31:1];
    // mux32_1 mux32_1_0(
    //     .select(shamt),
    //     .source(temp),
    //     .result(rd[0])
    // );
    //
    // genvar i, j;
    // generate
    //     for(i = 1;i < 31;i = i + 1) begin
    //         for(j = 0;j <= i;j = j + 1) begin
    //             assign temp[j] = rt[i - j];
    //         end
    //         assign temp[31:i + 1] = zero[31:i + 1];
    //         mux32_1 mux32_1_1_30(
    //             .select(shamt),
    //             .source(temp),
    //             .result(rd[i])
    //         );
    //     end
    // endgenerate
    //
    // mux32_1 mux32_1_31(
    //     .select(shamt),
    //     .source(rt),
    //     .result(rd[31])
    // );

endmodule
