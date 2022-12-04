`timescale 1ns/10ps
`include "../src/alu_32_control.v"

module alu_32_control_tb;

    reg [2:0] ALUOp;
    reg [5:0] func;
    wire [3:0] ALUCtr;

    alu_32_control alu_32_control_0(
        .ALUOp          (ALUOp),
        .func           (func),
        .ALUCtr         (ALUCtr)
    );

    initial begin
        $display("---------alu_32_control----------");
        $display("ALUOp         func        ALUCtr");
        #10
        ALUOp = 3'b100; func = 6'b100000;
        #10
        ALUOp = 3'b100; func = 6'b100001;
        #10
        ALUOp = 3'b100; func = 6'b100010;
        #10
        ALUOp = 3'b100; func = 6'b100011;
        #10
        ALUOp = 3'b100; func = 6'b100100;
        #10
        ALUOp = 3'b100; func = 6'b100101;
        #10
        ALUOp = 3'b100; func = 6'b101010;
        #10
        ALUOp = 3'b100; func = 6'b101011;
        #10
        ALUOp = 3'b100; func = 6'b000000;

        #10
        ALUOp = 3'b010; func = 6'b001000;

        #10
        ALUOp = 3'b000; func = 6'b100011;
        #10
        ALUOp = 3'b000; func = 6'b101011;

        #10
        ALUOp = 3'b001; func = 6'b000100;
        #10
        ALUOp = 3'b001; func = 6'b000101;
        #10
        ALUOp = 3'b001; func = 6'b000111;
        
        #20
        $display("---------------------------------");
        $finish;
    end

    always @(ALUOp, func) begin
        #5
        $display("%b         %b          %b",
                  ALUOp,      func,       ALUCtr);
    end

endmodule
