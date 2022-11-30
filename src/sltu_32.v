`include "../src/sub_32.v"

module sltu_32(rs, rt, rd, overflow);
    input [31:0] rs, rt;
    output [31:0] rd;
    output overflow;

    wire borrow;

    sub_32 sub_32_0(
        .a(rs),
        .b(rt),
        .borrow(borrow),
        .overflow(overflow)
    );

    assign rd = {31'b0, borrow};

endmodule
