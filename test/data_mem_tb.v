module data_mem_tb;  //data_mem
  
  reg clk;
  reg t_cs;
  reg t_oe;
  reg t_we;
  reg [31:0] t_addr;
  reg [31:0] t_din;
  wire [31:0] t_dout;
  
  parameter data_file = "data/bills_branch.dat";
  parameter clk_p = 10;     // clk period
  
  data_mem #(.mem_file(data_file)) data_cache(.clk(clk) , .cs(t_cs) , .oe(t_oe) , .we(t_we) , .addr(t_addr) , .din(t_din) , .dout(t_dout));
 
  initial clk = 1'b1;
  always #(clk_p/2) clk = ~clk;
  
  initial
    begin
      t_cs <= 1'b1;    //always on
      t_we <= 1'b0;
      t_oe <= 1'b1;    //always on
      t_addr <= 32'h00000000;
      t_din <= 32'h00000000;
      #clk_p
      // initialization is done; start reading

      t_addr <= 32'h1000000c;
      #clk_p

      t_addr <= 32'h10000024;
      #clk_p

      t_addr <= 32'h10000000;
      #clk_p

      //start writing
      t_we <=1'b1;
      t_addr <= 32'h10000028;
      t_din <= 32'h0000FF28;
      #clk_p

      t_addr <= 32'h10000024;
      t_din <= 32'h0000FF24;
      #clk_p

      //stop writing
      t_we <=1'b0;
      t_addr <= 32'h1000000c;
      #clk_p

      t_addr <= 32'h10000028;
      #clk_p

      #(clk_p*5)
      $finish;

  end
  
endmodule

