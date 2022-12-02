module inst_mem(cs,oe,we,addr,din,dout);

  parameter mem_file = "";
  input cs;
  input oe;
  input we;
  input [31:0] addr;
  input [31:0] din;
  output [31:0] dout;

  sram #(.mem_file(mem_file)) instruction_mem(.cs(cs), .oe(oe), .we(we), .addr(addr), .din(din), .dout(dout));
endmodule