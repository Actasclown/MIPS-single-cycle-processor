`timescale 1ns/10ps
`include "../src/sll_32.v"

module sll_32_tb;
    reg [31:0] rt;
    reg [4:0] shamt;
    wire [31:0] rd;

    sll_32 sll_32_0(
        .rt(rt),
        .shamt(shamt),
        .rd(rd)
    );

    initial begin
        #10
        rt = 32'h805C9BD2;

        #10
        $display("-----------------sll_32------------------");
        $display("rt: %b", rt);
        $display("shamt   rd");

        #10
        shamt = 5'd0;

        #10
        shamt = 5'd1;

        #10
        shamt = 5'd2;

        #10
        shamt = 5'd3;

        #10
        shamt = 5'd4;

        #10
        shamt = 5'd5;

        #10
        shamt = 5'd6;

        #10
        shamt = 5'd7;

        #10
        shamt = 5'd8;

        #10
        shamt = 5'd9;

        #10
        shamt = 5'd10;

        #10
        shamt = 5'd11;

        #10
        shamt = 5'd12;

        #10
        shamt = 5'd13;

        #10
        shamt = 5'd14;

        #10
        shamt = 5'd15;

        #10
        shamt = 5'd16;

        #10
        shamt = 5'd17;

        #10
        shamt = 5'd18;

        #10
        shamt = 5'd19;

        #10
        shamt = 5'd20;

        #10
        shamt = 5'd21;

        #10
        shamt = 5'd22;

        #10
        shamt = 5'd23;

        #10
        shamt = 5'd24;

        #10
        shamt = 5'd25;

        #10
        shamt = 5'd26;

        #10
        shamt = 5'd27;

        #10
        shamt = 5'd28;

        #10
        shamt = 5'd29;

        #10
        shamt = 5'd30;

        #10
        shamt = 5'd31;

        #20
        $display("-----------------------------------------");
        $finish;
    end

    always @(shamt) begin
        #5
        $display("   %d   %b", shamt, rd);
    end

endmodule
