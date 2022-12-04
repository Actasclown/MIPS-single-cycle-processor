
module signext_32(imm, extended);

    input [15:0] imm;
    output [31:0] extended;

    assign extended = {imm[15], imm[15], imm[15], imm[15],
                       imm[15], imm[15], imm[15], imm[15],
                       imm[15], imm[15], imm[15], imm[15],
                       imm[15], imm[15], imm[15], imm[15], imm};


endmodule
