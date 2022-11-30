`timescale 1ns/10ps
`include "../src/alu_32.v"

module alu_32_tb;
    reg [31:0] a, b;
    reg [3:0] control;
    reg [4:0] shamt;
    wire [31:0] result;
    wire carry_out, overflow, zero;

    alu_32 alu_32_0(
        .a(a),
        .b(b),
        .control(control),
        .shamt(shamt),
        .result(result),
        .carry_out(carry_out),
        .overflow(overflow),
        .zero(zero)
    );

    initial begin
        $display("--------------------------------------alu_32---------------------------------------");

        #10
        control = 4'b1000;
        shamt = 5'd0;
        $display("\n--------------------------------------add_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        a = 32'd1;
        b = 32'd2;
        #10
        a = 32'h7f898899;
        b = 32'h45898899;
        #10
        a = 32'hffffffff;
        b = 32'h1;
        #10
        a = 32'hffffffff;
        b = 32'h80000000;
        #10
        shamt = 5'd5;

        #10
        control = 4'b1010;
        shamt = 5'd0;
        $display("\n--------------------------------------sub_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        a = 32'h7f898899;
        b = 32'h45898899;
        #10
        a = 32'hf5898899;
        b = 32'h7f898899;
        #10
        a = 32'd7;
        b = 32'd12;
        #10
        a = 32'h7f898899;
        b = 32'hf5898899;
        #10
        a = 32'h7f898899;
        b = 32'h7f898899;

        #10
        control = 4'b1001;
        shamt = 5'd0;
        $display("\n--------------------------------------slt_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        a = 32'h7fffffff;
        b = 32'hfffffff9;
        #10
        a = 32'h80000000;
        b = 32'h9;
        #10
        a = 32'hc;
        b = 32'hfffffff9;
        #10
        a = 32'ha;
        b = 32'h4;
        #10
        a = 32'hfffffff3;
        b = 32'hfffffff9;
        #10
        a = 32'hfffffff3;
        b = 32'hfffffff3;
        #10
        a = 32'hfffffff3;
        b = 32'hffff0003;

        #10
        control = 4'b1011;
        shamt = 5'd0;
        $display("\n--------------------------------------sltu_32--------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        a = 32'h7fffffff;
        b = 32'hfffffff9;
        #10
        a = 32'h80000000;
        b = 32'h9;
        #10
        a = 32'hc;
        b = 32'hfffffff9;
        #10
        a = 32'ha;
        b = 32'h4;
        #10
        a = 32'hfffffff3;
        b = 32'hfffffff9;
        #10
        a = 32'hfffffff3;
        b = 32'hfffffff3;
        #10
        a = 32'hfffffff3;
        b = 32'hffff0003;

        #10
        control = 4'b1100;
        shamt = 5'd0;
        $display("\n--------------------------------------and_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        a = 32'b00000000000000000000000000000000;
        b = 32'b00000000000000000000000000000000;
        #10
        a = 32'b10001000100000000000110000000000;
        b = 32'b00000001000000000110010000000000;

        #10
        control = 4'b1101;
        shamt = 5'd0;
        $display("\n---------------------------------------or_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        a = 32'b00000000000000000000000000000000;
        b = 32'b00000000000000000000000000000000;
        #10
        a = 32'b00000000000000000000000000000010;
        b = 32'b00000000000000000000000000001000;
        #10
        a = 32'b00000000000000000000000000000110;
        b = 32'b00000000000000000000000000001100;

        #10
        control = 4'b1110;
        shamt = 5'd0;
        $display("\n--------------------------------------xor_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        a = 32'b00000000000000000000000000000000;
        b = 32'b00000000000000000000000000000000;
        #10
        a = 32'b00000000000000000000000000000010;
        b = 32'b00000000000000000000000000001000;
        #10
        a = 32'b00000000000000000000000000000110;
        b = 32'b00000000000000000000000000001100;

        #10
        control = 4'b0000;
        a = 32'b00000000000000000000000000000000;
        $display("\n--------------------------------------sll_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        b = 32'b00000000000000000000000000000001;
        shamt = 5'd0;
        #10
        b = 32'b00000000000000000000000000000010;
        shamt = 5'd2;
        #10
        b = 32'b00000000000000000000000000000110;
        shamt = 5'd20;
        #10
        b = 32'b00000000000000000000000001100000;
        shamt = 5'd29;

        #10
        control = 4'b0010;
        a = 32'b00000000000000000000000000000000;
        $display("\n--------------------------------------srl_32---------------------------------------");
        $display("          a              b   control shamt      result  carry_out   overflow   zero");
        b = 32'b10000000000000000000000000000000;
        shamt = 5'd2;
        #10
        b = 32'b00000000000100000000000000000000;
        shamt = 5'd9;
        #10
        b = 32'b00000000000000000000000000000110;
        shamt = 5'd20;




        #20
        $display("\n-----------------------------------------------------------------------------------");
        $finish;
    end

    always @(a, b, control, shamt) begin
        #5
        $display("%d    %d   %b       %d %d  %b           %b             %b",
            $signed(a), $signed(b), control, shamt, $signed(result), carry_out, overflow, zero);
    end

endmodule
