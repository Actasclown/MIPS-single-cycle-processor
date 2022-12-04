`include "../src/mux_n.v"
`include "../lib/and_gate.v"
`include "../src/mux8_1_n.v"
`include "../lib/or_gate.v"

module alu_32_control(ALUOp, func, ALUCtr);
    input [2:0]     ALUOp;
    input [5:0]     func;
    output [3:0]    ALUCtr;

    wire [3:0]      ALUCtr_sll, ALUCtr_branch, ALUCtr_lw_sw_addi;
    wire [3:0]      ALUCtr_R_type;
    wire [3:0]      ALUCtr_not_R_type;
    wire [2:0]      select;
    wire [3:0]      ALUCtr_other_R_type;

    assign          ALUCtr_sll = 4'b0000;
    assign          ALUCtr_branch = 4'b1010;        //sub
    assign          ALUCtr_lw_sw_addi = 4'b1000;    //add
    assign          select[0] = func[0];
    assign          select[1] = func[1];

    or_gate or_gate_slt(.x(func[2]), .y(func[3]), .z(select[2]));
    mux8_1_n #(.n(4)) mux8_1_0(
        .select(select),
        .s_000(4'b1000),
        .s_001(4'b1000),
        .s_010(4'b1010),
        .s_011(4'b1010),
        .s_100(4'b1100),
        .s_101(4'b1101),
        .s_110(4'b1001),
        .s_111(4'b1011),
        .result(ALUCtr_other_R_type)
    );

    mux_n #(.n(4)) mux_sll(.sel(func[5]), .src0(ALUCtr_sll), .src1(ALUCtr_other_R_type), .z(ALUCtr_R_type));
    mux_n #(.n(4)) mux_not_r_type(.sel(ALUOp[0]), .src0(ALUCtr_lw_sw_addi), .src1(ALUCtr_branch), .z(ALUCtr_not_R_type));
    mux_n #(.n(4)) mux_r_type(.sel(ALUOp[2]), .src0(ALUCtr_not_R_type), .src1(ALUCtr_R_type), .z(ALUCtr));

endmodule
