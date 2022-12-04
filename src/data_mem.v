module data_mem(clk,output_en,MemWr,address,data_in,data_out);

  parameter mem_file="";
  input clk;
  input output_en;
  input MemWr;
  input [31:0] address;
  input [31:0] data_in;
  output [31:0] data_out;

  syncram #(.mem_file(mem_file)) data_mem(.clk(clk),.cs(1'b1), .oe(output_en), .we(MemWr), .addr(address), .din(data_in), .dout(data_out));


endmodule