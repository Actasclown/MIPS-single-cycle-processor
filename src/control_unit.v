`include "../lib/and_gate.v"
`include "../lib/not_gate.v"
`include "../lib/or_gate.v"

module control_unit(opcode, RegDst, BranchEQ, BranchNE, BranchGTZ, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);

    input   [5:0] opcode;
    output  RegDst;
    output  BranchEQ;
    output  BranchNE;
    output  BranchGTZ;
    output  MemRead;
    output  MemToReg;
    output  [2:0] ALUOp;
    output  MemWrite;
    output  ALUSrc;
    output  RegWrite;
    //output ExtOP;     no situation needs unsigned extend

    wire    LW_or_SW;
    assign  LW_or_SW = opcode[5];

    wire    SW;
    and_gate and_gate_sw(.x(LW_or_SW), .y(opcode[3]), .z(SW));
    wire    not_sw;
    not_gate not_gate_not_sw(.x(opcode[3]), .z(not_sw));
    wire    LW;
    and_gate and_gate_lw(.x(LW_or_SW), .y(not_sw), .z(LW));

    wire    not_lw_sw;
    not_gate not_gate_not_lw_sw(.x(LW_or_SW), .z(not_lw_sw));

    wire    branch;
    assign  branch = opcode[2];
    wire    not_branch;
    not_gate not_gate_not_branch(.x(branch), .z(not_branch));
    wire    not_bne_bgtz;
    not_gate not_gate_not_bne_bgtz(.x(opcode[0]), .z(not_bne_bgtz));
    wire    BEQ;
    and_gate and_gate_beq(.x(branch), .y(not_bne_bgtz), .z(BEQ));
    wire    BGTZ;
    and_gate and_gate_bgtz(.x(branch), .y(opcode[1]), .z(BGTZ));
    wire    BNE;
    wire    not_beq, not_bgtz, not_beq_bgtz;
    not_gate not_gate_not_beq(.x(BEQ), .z(not_beq));
    not_gate not_gate_not_bgtz(.x(BGTZ), .z(not_bgtz));
    and_gate and_gate_not_beq_bgtz(.x(not_beq), .y(not_bgtz), .z(not_beq_bgtz));
    and_gate and_gate_bne(.x(branch), .y(not_beq_bgtz), .z(BNE));
    assign  BranchEQ = BEQ;
    assign  BranchNE = BNE;
    assign  BranchGTZ = BGTZ;

    wire    addi;
    and_gate and_gate_addi(.x(not_lw_sw), .y(opcode[3]), .z(addi));
    wire    not_addi;
    not_gate not_gate_not_addi(.x(addi), .z(not_addi));

    wire    not_branch_lw_sw;
    and_gate and_gate_not_branch_lw_sw(.x(not_lw_sw), .y(not_branch), .z(not_branch_lw_sw));
    wire    R_type;
    and_gate and_gate_R_type(.x(not_branch_lw_sw), .y(not_addi), .z(R_type));

    assign  RegDst = R_type;
    assign  MemRead = LW;
    assign  MemToReg = LW;

    assign  ALUOp[2] = R_type;
    assign  ALUOp[1] = addi;
    assign  ALUOp[0] = branch;

    assign  MemWrite = SW;

    or_gate or_gate_alu_src(.x(LW_or_SW), .y(addi), .z(ALUSrc));
    wire    arithmetic;
    or_gate or_gate_arithmetic(.x(R_type), .y(addi), .z(arithmetic));
    or_gate or_gate_reg_write(.x(arithmetic), .y(LW), .z(RegWrite));

endmodule
