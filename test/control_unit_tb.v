`timescale 1ns/10ps
`include "../src/control_unit.v"

module control_unit_tb;

    reg [5:0]   opcode;
    wire        RegDst;
    wire        BranchEQ;
    wire        BranchNE;
    wire        BranchGTZ;
    wire        MemRead;
    wire        MemToReg;
    wire [2:0]  ALUOp;
    wire        MemWrite;
    wire        ALUSrc;
    wire        RegWrite;

    control_unit control_unit_0(
        .opcode     (opcode),
        .RegDst     (RegDst),
        .BranchEQ   (BranchEQ),
        .BranchNE   (BranchNE),
        .BranchGTZ  (BranchGTZ),
        .MemRead    (MemRead),
        .MemToReg   (MemToReg),
        .ALUOp      (ALUOp),
        .MemWrite   (MemWrite),
        .ALUSrc     (ALUSrc),
        .RegWrite   (RegWrite)
    );

    initial begin
        $display("--------------------------------------control_unit---------------------------------------");
        $display("opcode RegDst BranchEQ BranchNE BranchGTZ MemRead MemToReg ALUOp MemWrite ALUSrc RegWrite");
        #10
        opcode = 6'b000000;
        #10
        opcode = 6'b001000;
        #10
        opcode = 6'b100011;
        #10
        opcode = 6'b101011;
        #10
        opcode = 6'b000100;
        #10
        opcode = 6'b000101;
        #10
        opcode = 6'b000111;
        #20
        $display("-----------------------------------------------------------------------------------------");
        $finish;
    end

    always @(opcode) begin
        #5
        $display("%b      %b        %b        %b        %b        %b        %b   %b        %b      %b        %b",
                  opcode, RegDst, BranchEQ, BranchNE, BranchGTZ, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    end

endmodule
