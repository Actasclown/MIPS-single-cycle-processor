module register_file (clk, rstb, RegWr, RegDst, Rs, Rt, Rd, busW, busA, busB);

input clk, rstb;
input RegWr;                // write_enable; 1-> enable
input RegDst;               // 1: Rw = Rd;   0:Rt
input [4:0] Rs, Rt, Rd;    
input [31:0] busW;          // data_in
output [31:0] busA, busB;   // data_out

reg [31:0] mem [0:31];      // 	reg [wordsize-1:0] array_name [0:arraysize-1]

wire [4:0] Rw;              // addr for write

assign Rw = RegDst? Rd: Rt;

assign busA = mem[Rs];
assign busB = mem[Rt];

always @(negedge clk or negedge rstb) begin
  if(~rstb) begin
    mem[0] <= 32'h00000000;
    mem[1] <= 32'h00000000;
    mem[2] <= 32'h00000000;
    mem[3] <= 32'h00000000;
    mem[4] <= 32'h00000000;
    mem[5] <= 32'h00000000;
    mem[6] <= 32'h00000000;
    mem[7] <= 32'h00000000;
    mem[8] <= 32'h00000000;
    mem[9] <= 32'h00000000;
    mem[10] <= 32'h00000000;
    mem[11] <= 32'h00000000;
    mem[12] <= 32'h00000000;
    mem[13] <= 32'h00000000;
    mem[14] <= 32'h00000000;
    mem[15] <= 32'h00000000;
    mem[16] <= 32'h00000000;
    mem[17] <= 32'h00000000;
    mem[18] <= 32'h00000000;
    mem[19] <= 32'h00000000;
    mem[20] <= 32'h00000000;
    mem[21] <= 32'h00000000;
    mem[22] <= 32'h00000000;
    mem[23] <= 32'h00000000;
    mem[24] <= 32'h00000000;
    mem[25] <= 32'h00000000;
    mem[26] <= 32'h00000000;
    mem[27] <= 32'h00000000;
    mem[28] <= 32'h00000000;
    mem[29] <= 32'h00000000;
    mem[30] <= 32'h00000000;
    mem[31] <= 32'h00000000;
  end
  else if (RegWr) begin
    mem[Rw] <= busW;
  end
end

endmodule