module data_mem(clk,cs,oe,we,addr,din,dout);

  parameter mem_file="";
  input clk;
  input cs;
  input oe;
  input we;
  input [31:0] addr;
  input [31:0] din;
  output [31:0] dout;

  syncram #(.mem_file(mem_file)) data_mem(.clk(~clk),.cs(cs), .oe(oe), .we(we), .addr(addr), .din(din), .dout(dout));


endmodule