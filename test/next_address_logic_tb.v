`timescale 1ns/10ps
`include "../src/next_address_logic.v"




module next_address_logic_tb;

    reg [31:0] instruction_t;
    reg jump_t, clk_t, reset_t, zero_t, branch_t; 
    wire [31:0] addr_t;

    
    next_address_logic next_address_log_0(
        .addr(addr_t),
        .clk(clk_t),
        .instruction(instruction_t),
        .rst(reset_t),
        .zero(zero_t),
        .branch(branch_t),
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
        $display("-----------------next_address_logic_32 reset------------------");
        
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
        $display("-----------------next_address_logic_32 next_address_logic + 4------------------");
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
        $display("-----------------next_address_logic_32 next_address_logic + 4------------------");
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

        $display("-----------------next_address_logic_32 branch------------------");
        $display("clk_t:   %b", clk_t);
        $display("reset_t:  %b", reset_t);
        $display("branch_t:  %b", branch_t);
        $display("jump_t:  %b", jump_t);
        $display("zero_t:  %b", zero_t);
        $display("instruction_t:  %h", instruction_t);
        $display("addr_t in hex: %h", addr_t);
         $display("addr_t in binary: %b", addr_t);

        branch_t = 1'bx;
        zero_t = 1'bx;
        jump_t = 1'b1;
        instruction_t = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
        clk_t = 1'b1;
        #10
        clk_t = 1'b0;
        #10

    end


endmodule

    





