module inst_mem_tb;         // instruction mem
  
  reg t_cs;
  reg t_oe;
  reg t_we;
  reg [31:0] t_addr;
  reg [31:0] t_din;
  wire [31:0] t_dout;

  parameter program_file = "data/bills_branch.dat";
  
  inst_mem  #(.mem_file(program_file)) instruction_mem (.cs(t_cs) , .oe(t_oe) , .we(t_we) , .addr(t_addr) , .din(t_din) , .dout(t_dout));
  
  initial
    begin
      
      t_cs = 1'b1;            //chip enable (should be always 1)
      t_oe = 1'b1;            //read enalbe (should be always 1)
      t_we = 1'b0;            //write enable (should be always 0) (can't write instruction mem)
      
      t_addr = 32'h00400050;  //read addr
      t_din = 32'hFFFFFFFF;   //doesn't matter
      #10

      t_addr = 32'h00400050;  //read addr
      #10

      t_addr = 32'h0040003c;  //read addr
      #10

      #20

      $finish;
     
      
     
  end
  
endmodule

