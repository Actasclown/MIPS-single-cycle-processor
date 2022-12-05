`timescale 1ns/10ps
`include "../src/pc_head_32.v"

module pc_head_32_tb;

    reg [31:0] addr_t;
    wire [31:0] new_addr_t;
    reg clk_t;
    reg reset_t;
    
    pc_head_32 pc_head_32_0(
        .addr(addr_t),
        .clk(clk_t),
        .new_addr(new_addr_t),
        .reset(reset_t)
    );

    

    initial begin

        addr_t = 32'h0000_0001;
        
        reset_t = 1'b1;
        #10
        reset_t = 1'b0;
        #10
        reset_t = 1'b1;
        $display("-----------------pc_head_32------------------");
        $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("reset_t:  %b", reset_t);
        $display("new_addr_t:  %h", new_addr_t);


        clk_t = 1'b0;
        #10
        clk_t = 1'b1;
        #10
        clk_t = 1'b0;
        $display("-----------------pc_head_32------------------");
        $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);
        $display("reset_t:  %b", reset_t);


        clk_t = 1'b1;
        #10
        $display("-----------------pc_head_32------------------");
         $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);

        
        clk_t = 1'b0;
        #10
        $display("-----------------pc_head_32------------------");
         $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);

        addr_t = 32'h0000_ffff;
        clk_t = 1'b1;
        #10
        $display("-----------------pc_head_32------------------");
         $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);

        
        clk_t = 1'b0;
        #10
        $display("-----------------pc_head_32------------------");
        $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);

        addr_t = 32'h0000_0001;
        clk_t = 1'b1;
        #10
        $display("-----------------pc_head_32------------------");
         $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);

        
        clk_t = 1'b0;
        #10
        $display("-----------------pc_head_32------------------");
        $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);

        clk_t = 1'b0;
        #10
        $display("-----------------pc_head_32------------------");
        $display("addr_t: %b", addr_t);
        $display("clk_t:   %b", clk_t);
        $display("new_addr_t:  %b", new_addr_t);

        


    end


endmodule

    





