`include "../lib/mux.v"

module mux32_1 (source, select, result);
    input [31:0] source;
    input [4:0] select;
    output result;

    wire [15:0] result_16;
    wire [7:0]  result_8;
    wire [3:0]  result_4;
    wire [1:0]  result_2;

    genvar i;
    generate
        for(i = 0;i < 16;i = i + 1) begin
            mux mux_select_4(
                .sel(select[4]),
                .src0(source[i]),
                .src1(source[i + 16]),
                .z(result_16[i])
            );
        end

        for(i = 0;i < 8;i = i + 1) begin
            mux mux_select_3(
                .sel(select[3]),
                .src0(result_16[i]),
                .src1(result_16[i + 8]),
                .z(result_8[i])
            );
        end

        for(i = 0;i < 4;i = i + 1) begin
            mux mux_select_2(
                .sel(select[2]),
                .src0(result_8[i]),
                .src1(result_8[i + 4]),
                .z(result_4[i])
            );
        end

        for(i = 0;i < 2;i = i + 1) begin
            mux mux_select_1(
                .sel(select[1]),
                .src0(result_4[i]),
                .src1(result_4[i + 2]),
                .z(result_2[i])
            );
        end
    endgenerate

    mux mux_select_0(
        .sel(select[0]),
        .src0(result_2[0]),
        .src1(result_2[1]),
        .z(result)
    );

endmodule
