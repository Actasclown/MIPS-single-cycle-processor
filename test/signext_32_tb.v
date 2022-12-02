`timescale 1ns/10ps
`include "../src/signext_32.v"

module signext_32_tb;
    wire [31:0] extended_t;
    reg [15:0] imm_t;


    signext_32 signext_32_0(
        .extended(extended_t),
        .imm(imm_t)
    );

    initial begin

        imm_t = 16'h1111;
        #10
        $display("imm:   %b", imm_t);
        $display("extended:   %b", extended_t);
    
        $finish;
    end

endmodule
