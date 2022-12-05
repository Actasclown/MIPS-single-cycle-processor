// `include "../lib/mux_32.v"
// `include "../lib/mux_32.v"
// `include "../lib/dffr_a.v"
`include "../src/dffr_a_32.v"

module pc_head_32(addr, clk, new_addr, reset);

    input [31:0] addr;
    input clk;
    input reset;
    output [31:0] new_addr;

    wire [31:0] zero;
    wire i_clk, i_reset;

    assign zero = 32'h00400020;


    // always @ (negedge reset or negedge clk) begin
        
    //     if(~reset) begin
    //         new_addr <= 32'h00400020;
    //     end else begin
    //         new_addr <= addr;
    //     end
    // end



    not_gate not_gate_0(.x(clk), .z(i_clk));
    not_gate not_gate_1(.x(reset), .z(i_reset));

    dffr_a_32 dffr_a_0(
        .clk(i_clk),
        .d(addr),
        .q(new_addr), 
        .arst(1'b0),
        .aload(i_reset), 
        .adata(zero), 
        .enable(i_clk)
        );
    



endmodule
