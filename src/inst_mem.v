module inst_mem(Adr,opcode,Rs,Rt,Rd,shamt,func,imm16);

  parameter mem_file = "";
  input [31:0] Adr;

  output [5:0] opcode;
  output [4:0] Rs;
  output [4:0] Rt;
  output [4:0] Rd;
  output [4:0] shamt;
  output [5:0] func;
  output [15:0] imm16;

  wire [31:0] dout;

  sram #(.mem_file(mem_file)) instruction_mem(.cs(1'b1), .oe(1'b1), .we(1'b0), .addr(Adr), .din(32'd0), .dout(dout));

  assign opcode = dout[31:26];
  assign Rs = dout[25:21];
  assign Rt = dout[20:16];
  assign Rd = dout[15:11];
  assign shamt = dout[10:6];
  assign func = dout[5:0];
  assign imm16 = dout[15:0];

endmodule