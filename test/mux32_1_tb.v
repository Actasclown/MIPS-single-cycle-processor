`timescale 1ns/10ps
`include "../src/mux32_1.v"

module mux32_1_tb;
    reg [31:0] source;
    reg [4:0] select;
    wire result;

    mux32_1 mux32_1_0(
        .source(source),
        .select(select),
        .result(result)
    );

    initial begin
        #10
        source = 32'h805C9BD2;

        #10
        $display("----------------mux32_1-----------------");
        $display("source: %b", source);
        $display("select    result");

        #10
        select = 5'd0;

        #10
        select = 5'd1;

        #10
        select = 5'd2;

        #10
        select = 5'd3;

        #10
        select = 5'd4;

        #10
        select = 5'd5;

        #10
        select = 5'd6;

        #10
        select = 5'd7;

        #10
        select = 5'd8;

        #10
        select = 5'd9;

        #10
        select = 5'd10;

        #10
        select = 5'd11;

        #10
        select = 5'd12;

        #10
        select = 5'd13;

        #10
        select = 5'd14;

        #10
        select = 5'd15;

        #10
        select = 5'd16;

        #10
        select = 5'd17;

        #10
        select = 5'd18;

        #10
        select = 5'd19;

        #10
        select = 5'd20;

        #10
        select = 5'd21;

        #10
        select = 5'd22;

        #10
        select = 5'd23;

        #10
        select = 5'd24;

        #10
        select = 5'd25;

        #10
        select = 5'd26;

        #10
        select = 5'd27;

        #10
        select = 5'd28;

        #10
        select = 5'd29;

        #10
        select = 5'd30;

        #10
        select = 5'd31;

        #20
        $display("----------------------------------------");
        $finish;
    end

    always @(select) begin
        #5
        $display("  %d         %b", select, result);
    end

endmodule
