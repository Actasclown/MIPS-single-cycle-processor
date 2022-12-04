module inst_mem_tb;         // instruction mem

  reg [31:0] Adr;

  wire [5:0] opcode;
  wire [4:0] Rs;
  wire [4:0] Rt;
  wire [4:0] Rd;
  wire [4:0] shamt;
  wire [5:0] func;
  wire [15:0] imm16;
  wire [31:0] dout1, dout2;

  parameter program_file = "data/bills_branch.dat";
  
  inst_mem  #(.mem_file(program_file)) instruction_mem (.Adr(Adr), .opcode(opcode), .Rs(Rs), .Rt(Rt), .Rd(Rd), .shamt(shamt), .func(func), .imm16(imm16));
  
  assign dout1 = {opcode,Rs,Rt,Rd,shamt,func};
  assign dout2 = {opcode,Rs,Rt,imm16};

  initial
    begin
      
      Adr = 32'h00400050;  //read addr
     
      #10

      Adr = 32'h00400050;  //read addr
      #10

      Adr = 32'h0040003c;  //read addr
      #10

      #20

      $finish;
     
      
     
  end
  
endmodule

