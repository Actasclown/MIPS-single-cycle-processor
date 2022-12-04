// `include "../lib/mux_32.v"
`include "../lib/mux_32.v"

module pc_head_32(addr, clk, new_addr, reset);

    input [31:0] addr;
    input clk;
    input reset;
    output reg [31:0] new_addr;


    always @ (negedge reset) begin
        new_addr <= 32'h00400020;
    end

    always @ (negedge clk) begin
        new_addr <= addr;
    end

    // always @ (negedge reset or negedge clk) begin
        
    //     if(~reset) begin
    //         new_addr <= 32'h00400020;
    //     end else begin
    //         new_addr <= addr;
    //     end
    // end


endmodule

