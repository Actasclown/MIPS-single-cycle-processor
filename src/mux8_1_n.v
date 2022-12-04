`include "../src/mux8_1.v"

module mux8_1_n (select, s_000, s_001, s_010, s_011, s_100, s_101, s_110, s_111, result);
    parameter n = 4;
    input [2:0] select;
    input [n - 1:0] s_000, s_001, s_010, s_011, s_100, s_101, s_110, s_111;
    output [n - 1:0] result;

    genvar i;
    generate
        for(i = 0;i < n;i = i + 1) begin
            mux8_1 mux8_1_0 (
                .select(select),
                .s_000(s_000[i]),
                .s_001(s_001[i]),
                .s_010(s_010[i]),
                .s_011(s_011[i]),
                .s_100(s_100[i]),
                .s_101(s_101[i]),
                .s_110(s_110[i]),
                .s_111(s_111[i]),
                .result(result[i])
            );
        end
    endgenerate

endmodule
