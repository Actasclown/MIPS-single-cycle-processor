`include "../lib/or_gate.v"
`include "../lib/not_gate.v"

module zero_32(source, result);
    input [31:0] source;
    output [31:0] result;

    assign result[31:1] = 31'b0;

    wire [15:0] or_16;
    wire [7:0]  or_8;
    wire [3:0]  or_4;
    wire [1:0]  or_2;
    wire or_all;

    genvar i;
    generate
        for(i = 0;i < 16;i = i + 1) begin
            or_gate or_gate_4(
                .x(source[i]),
                .y(source[i + 16]),
                .z(or_16[i])
            );
        end

        for(i = 0;i < 8;i = i + 1) begin
            or_gate or_gate_3(
                .x(or_16[i]),
                .y(or_16[i + 8]),
                .z(or_8[i])
            );
        end

        for(i = 0;i < 4;i = i + 1) begin
            or_gate or_gate_2(
                .x(or_8[i]),
                .y(or_8[i + 4]),
                .z(or_4[i])
            );
        end

        for(i = 0;i < 2;i = i + 1) begin
            or_gate or_gate_1(
                .x(or_4[i]),
                .y(or_4[i + 2]),
                .z(or_2[i])
            );
        end
    endgenerate

    or_gate or_gate_0(
        .x(or_2[0]),
        .y(or_2[1]),
        .z(or_all)
    );

    not_gate not_gate_0(
        .x(or_all),
        .z(result[0])
    );

endmodule
