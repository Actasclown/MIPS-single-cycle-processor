// `include "../lib/mux_32.v"

module pc_head_32(addr, clk, new_addr);

    input [31:0] addr;
    input clk;
    output reg [31:0] new_addr;

    always @ (negedge clk) begin
        new_addr <= addr;
    end

endmodule