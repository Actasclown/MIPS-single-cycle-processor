//zhiwei
`include "../src/inst_mem.v"
`include "../src/data_mem.v"
`include "../src/register_file.v"
//youjia
`include "../src/pc_32.v"
`include "../src/signext_32.v"
//↑above is not merged yet
//yunqi
`include "../src/control_unit.v"
`include "../src/alu_32.v"
`include "../src/alu_32_control.v"

`include "../lib/not_gate.v"
`include "../lib/and_gate.v"
`include "../lib/or_gate.v"
`include "../src/mux_32.v"


module single_cycle_processor;

    wire [31:0] addr_inst;
    wire [5:0]  opcode;
    wire [4:0]  Rs;
    wire [4:0]  Rt;
    wire [4:0]  Rd;
    wire [4:0]  shamt;
    wire [5:0]  func;
    wire [15:0] imm16;
    wire        branch;

    reg         clk_inst_reg = 1'b0;
    reg         rst_inst_reg;
    reg         clk_data = 1'b0;

    inst_mem inst_mem_0(
        .Adr        (addr_inst),
        .opcode     (opcode),
        .Rs         (Rs),
        .Rt         (Rt),
        .Rd         (Rd),
        .shamt      (shamt),
        .func       (func),
        .imm16      (imm16)
    );

    pc_32 pc_32_0(
        .branch     (branch),
        .zero       (branch),
        .addr       (addr_inst),
        .jump       (1'b0),
        .clk        (clk_inst_reg),
        .reset      (rst_inst_reg),
        .instruction(imm16)
    );

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

    wire [3:0]  ALUCtr;
    wire [31:0] ALU_out;
    wire        carry_out, overflow, zero;
    wire        not_zero, not_negative;
    wire        BNE_out, BEQ_out, BGTZ_out_temp, BGTZ_out, branch_temp;

    not_gate not_gate_zero(.x(zero), .z(not_zero));
    not_gate not_gate_negative(.x(ALU_out[31]), .z(not_negative));      //nothing to do with carry_out
    and_gate and_gate_bne(.x(BranchNE), .y(not_zero), .z(BNE_out));
    and_gate and_gate_beq(.x(BranchEQ), .y(zero), .z(BEQ_out));
    and_gate and_gate_bgtz_temp(.x(BranchGTZ), .y(not_negative), .z(BGTZ_out_temp));
    and_gate and_gate_bgtz(.x(BGTZ_out_temp), .y(not_zero), .z(BGTZ_out));

    or_gate or_gate_bne_beq(.x(BNE_out), .y(BEQ_out), .z(branch_temp));
    or_gate or_gate_branch(.x(BGTZ_out), .y(branch_temp), .z(branch));

    wire [31:0] imm16_out_signex;
    wire [31:0] z_MUX_ALUSrc;
    signext_32 signext_32_0(.imm16(imm16), .out(imm16_out_signex));
    mux_32 mux_ALUsrc(.sel(ALUSrc), .src0(busB), .src1(imm16_out_signex), .z(z_MUX_ALUSrc));

    alu_32 alu_32_0(
        .a          (busA),
        .b          (z_MUX_ALUSrc),
        .control    (ALUCtr),
        .shamt      (shamt),
        .result     (ALU_out),
        .carry_out  (carry_out),
        .overflow   (overflow),
        .zero       (zero)
    );

    alu_32_control alu_32_control_0(
        .ALUOp      (ALUOp),
        .func       (func),
        .ALUCtr     (ALUCtr)
    );

    register_file register_file_0(
        .clk        (clk_inst_reg),
        .rstb       (rst_inst_reg),
        .RegWr      (RegWrite),
        .RegDst     (RegDst),
        .Rw         (Rd),
        .Ra         (Rs),
        .Rb         (Rt),
        .busW       (busW),
        .busA       (busA),
        .busB       (busB)
    );

    wire [31:0] MEM_out;

    data_mem data_mem_0(
        .clk        (clk_data),
        .output_en  (MemRead),
        .MemWr      (MemWrite),
        .address    (ALU_out),
        .data_in    (busB),
        .data_out   (MEM_out)
    );
    mux_32 mux_mem_to_reg(.sel(MemToReg), .src0(ALU_out), .src1(MEM_out), .z(busW));


endmodule
