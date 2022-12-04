module data_mem_tb;  //data_mem
  
  reg clk;
  reg output_en;
  reg MemWr;
  reg [31:0] address;
  reg [31:0] data_in;
  wire [31:0] data_out;
  
  parameter data_file = "data/bills_branch.dat";
  parameter clk_p = 10;     // clk period
  
  data_mem #(.mem_file(data_file)) data_cache(.clk(clk), .output_en(output_en) , .MemWr(MemWr) , .address(address) , .data_in(data_in) , .data_out(data_out));
 
  initial clk = 1'b1;
  always #(clk_p/2) clk = ~clk;
  
  initial
    begin

      MemWr <= 1'b0;
      output_en <= 1'b1;    //always on
      address <= 32'h00000000;
      data_in <= 32'h00000000;
      #clk_p
      // initialization is done; start reading

      address <= 32'h1000000c;
      #clk_p

      address <= 32'h10000024;
      #clk_p

      address <= 32'h10000000;
      #clk_p

      //start writing
      MemWr <=1'b1;
      address <= 32'h10000028;
      data_in <= 32'h0000FF28;
      #clk_p

      address <= 32'h10000024;
      data_in <= 32'h0000FF24;
      #clk_p

      //stop writing
      MemWr <=1'b0;
      address <= 32'h1000000c;
      #clk_p

      address <= 32'h10000028;
      #clk_p

      #(clk_p*5)
      $finish;

  end
  
endmodule

