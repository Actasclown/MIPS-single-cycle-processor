`include "../lib/mux.v"

module mux8_1(select, s_000, s_001, s_010, s_011, s_100, s_101, s_110, s_111, result);

    input [2:0] select;
    input s_000, s_001, s_010, s_011, s_100, s_101, s_110, s_111;
    output result;

    wire temp_0_0, temp_0_1, temp_0_2, temp_0_3;
    wire temp_1_0, temp_1_1;

    mux mux_0_0(.sel(select[0]), .src0(s_000), .src1(s_001), .z(temp_0_0));
    mux mux_0_1(.sel(select[0]), .src0(s_010), .src1(s_011), .z(temp_0_1));
    mux mux_0_2(.sel(select[0]), .src0(s_100), .src1(s_101), .z(temp_0_2));
    mux mux_0_3(.sel(select[0]), .src0(s_110), .src1(s_111), .z(temp_0_3));

    mux mux_1_0(.sel(select[1]), .src0(temp_0_0), .src1(temp_0_1), .z(temp_1_0));
    mux mux_1_1(.sel(select[1]), .src0(temp_0_2), .src1(temp_0_3), .z(temp_1_1));

    mux mux_2_0(.sel(select[2]), .src0(temp_1_0), .src1(temp_1_1), .z(result));

endmodule
