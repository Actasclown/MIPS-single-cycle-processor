
module signext_32(imm, extended);

    input [15:0] imm;
    output [31:0] extended;

    assign extended = {16'h00000, imm};


endmodule
