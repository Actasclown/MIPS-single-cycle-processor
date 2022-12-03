module data_mem_v1_tb;  //data_mem
  
  reg t_cs;
  reg t_oe;
  reg t_we;
  reg [31:0] t_addr;
  reg [31:0] t_din;
  wire [31:0] t_dout;
  
  parameter data_file = "data/bills_branch.dat";
  
  data_mem_v1 #(.mem_file(data_file)) data_cache(.cs(t_cs) , .oe(t_oe) , .we(t_we) , .addr(t_addr) , .din(t_din) , .dout(t_dout));
 
  initial
    begin
      t_cs <= 1'b1;    //always on
      t_we <= 1'b0;
      t_oe <= 1'b1;    //always on
      t_addr <= 32'h00000000;
      t_din <= 32'h00000000;
      #10
      // initialization is done; start reading

      t_addr <= 32'h1000000c;
      #10

      t_addr <= 32'h10000024;
      #10

      t_addr <= 32'h10000000;
      #10

      //start writing
      t_we <=1'b1;
      t_addr <= 32'h10000028;
      t_din <= 32'h0000FF28;
      #10

      t_addr <= 32'h10000024;
      t_din <= 32'h0000FF24;
      #10

      //stop writing
      t_we <=1'b0;
      t_addr <= 32'h1000000c;
      #10

      t_addr <= 32'h10000028;
      #50

      $finish;

  end
  
endmodule

