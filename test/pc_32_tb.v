`timescale 1ns/10ps
`include "../src/pc_32.v"




module pc_32_tb;

    reg [31:0] instruction_t;
    reg jump_t, clk_t, reset_t, zero_t, branch_t; 
    wire [31:0] addr_t;

    
    pc_32 pc_32_0(
        .addr(addr_t),
        .clk(clk_t),
        .instruction(instruction_t),
        .reset(reset_t),
        .zero(zero_t),
        .branch(branch_t),
        .jump(jump_t)
    );
    

    initial begin
        instruction_t = 32'h0000_0000;
        clk_t = 1'b0;
        reset_t = 1'b1;
        jump_t = 1'b0;
        branch_t = 1'b0;
        zero_t = 1'b0;


        
        #10
        reset_t = 1'b0;
        clk_t = 1'b1;
        clk_t = 1'b0;
        #10
        $display("-----------------pc_32 reset------------------");
        
        $display("clk_t:   %b", clk_t);
        $display("reset_t:  %b", reset_t);
        $display("branch_t:  %b", branch_t);
        $display("jump_t:  %b", jump_t);
        $display("zero_t:  %b", zero_t);
        $display("instruction_t:  %h", instruction_t);
        $display("addr_t: %h", addr_t);


        clk_t = 1'b1;
        #10
        clk_t = 1'b0;
        #10
        $display("-----------------pc_32 pc + 4------------------");
        $display("clk_t:   %b", clk_t);
        $display("reset_t:  %b", reset_t);
        $display("branch_t:  %b", branch_t);
        $display("jump_t:  %b", jump_t);
        $display("zero_t:  %b", zero_t);
        $display("instruction_t:  %h", instruction_t);
        $display("addr_t: %h", addr_t);

        clk_t = 1'b1;
        #10
        clk_t = 1'b0;
        #10
        $display("-----------------pc_32 pc + 4------------------");
        $display("clk_t:   %b", clk_t);
        $display("reset_t:  %b", reset_t);
        $display("branch_t:  %b", branch_t);
        $display("jump_t:  %b", jump_t);
        $display("zero_t:  %b", zero_t);
        $display("instruction_t:  %h", instruction_t);
        $display("addr_t: %h", addr_t);

        branch_t = 1'b1;
        zero_t = 1'b1;
        instruction_t = 32'h0000_1000;
        clk_t = 1'b1;
        #10
        clk_t = 1'b0;
        #10

        $display("-----------------pc_32 branch +positive------------------");
        $display("clk_t:   %b", clk_t);
        $display("reset_t:  %b", reset_t);
        $display("branch_t:  %b", branch_t);
        $display("jump_t:  %b", jump_t);
        $display("zero_t:  %b", zero_t);
        $display("instruction_t:  %h", instruction_t);
        $display("addr_t in hex: %h", addr_t);
        $display("addr_t in binary: %b", addr_t);


        branch_t = 1'b1;
        zero_t = 1'b1;
        instruction_t = 32'h0000_ff98;
        clk_t = 1'b1;
        #10
        clk_t = 1'b0;
        #10

        $display("-----------------pc_32 branch +negative------------------");
        $display("clk_t:   %b", clk_t);
        $display("reset_t:  %b", reset_t);
        $display("branch_t:  %b", branch_t);
        $display("jump_t:  %b", jump_t);
        $display("zero_t:  %b", zero_t);
        $display("instruction_t:  %h", instruction_t);
        $display("addr_t in hex: %h", addr_t);
        $display("addr_t in binary: %b", addr_t);

        // branch_t = 1'bx;
        // zero_t = 1'bx;
        // jump_t = 1'b1;
        // instruction_t = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
        // clk_t = 1'b1;
        // #10
        // clk_t = 1'b0;
        // #10

        // $display("-----------------pc_32 jump------------------");
        // $display("clk_t:   %b", clk_t);
        // $display("reset_t:  %b", reset_t);
        // $display("branch_t:  %b", branch_t);
        // $display("jump_t:  %b", jump_t);
        // $display("zero_t:  %b", zero_t);
        // $display("instruction_t:  %h", instruction_t);
        // $display("addr_t hex: %h", addr_t);
        // $display("addr_t binary: %b", addr_t);

        // branch_t = 1'b0;
        // zero_t = 1'b0;
        // jump_t = 1'b0;
        // instruction_t = 32'h00450000;
        // clk_t = 1'b1;
        // #10
        // clk_t = 1'b0;
        // #10

        // $display("-----------------pc_32 pc + 4------------------");
        // $display("clk_t:   %b", clk_t);
        // $display("reset_t:  %b", reset_t);
        // $display("branch_t:  %b", branch_t);
        // $display("jump_t:  %b", jump_t);
        // $display("zero_t:  %b", zero_t);
        // $display("instruction_t:  %h", instruction_t);
        // $display("addr_t: %h", addr_t);

    end


endmodule

    





