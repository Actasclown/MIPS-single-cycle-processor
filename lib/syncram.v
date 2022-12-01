module syncram(clk,cs,oe,we,addr,din,dout);     // data mem
  
  parameter mem_file = "";
  input clk;
  input cs;
  input oe;
  input we;
  input [31:0] addr;
  input [31:0] din;
  output reg [31:0] dout;
  
  integer check_hex = 1;
  integer file;
  integer ram_size = 0; // to keep track of elements in the ram
  
  integer char; // to read line by line
  integer r; 
  integer c = 0; // index for ram writing/reading
  integer i = 0; // index for hex checking
  integer initNeeded = 1;
  integer check_sram = 0;
  integer addr_found = 1;
  
  reg [3:0] slash;
  reg [31:0] addr_value;
  reg [31:0] data_value;
  reg [8*100:1] line; // line buffer
  reg [31:0] dbuf;
  
  reg [31:0] mem [49:0][1:0]; // memory to hold addr and data.
  
  
  task initiate;
        begin
        file = $fopen(mem_file , "r");
        if (file==0) begin
          $display("ERROR: file not found!");
          $finish;
        end
        char = $fgetc(file);
        c = 0; // c for counter for mem
        while (char!=-1) begin
      
          line = "";
          slash = "";
          addr_value = 32'b0;
          data_value = 32'b0;
      
          r = $ungetc(char , file);
          r = $fgets(line , file);
      
          r = $sscanf(line , "%h %s %h" , addr_value , slash , data_value);
          
          if (r==3) begin
            mem[c][0] = addr_value;
            mem[c][1] = data_value;
            $display ("Addr is written: %h" , mem[c][0]);
            $display ("Data is written: %h" , mem[c][1]);
            c = c+1;
            ram_size = ram_size+1;
          end
          else if ((r==2) || (r==1)) begin
            $display("ERROR: Data %h is not in hex format: " , data_value);
            $finish;
          end
        
          char = $fgetc(file);
     
          end
        end
      endtask
      
      
      // check ram if it is recorded >> for debugging
      task checkRAM;
        begin
          for (c=0; c<49 ; c=c+1) begin
            $display ("Addr is checking: %h" , mem[c][0]);
            $display ("Data is checking: %h" , mem[c][1]);
          end
        end
      endtask
      
      // write to RAM: if addr is there update it! else it is a new input
      task writeRAM;
        input [31:0] addr;
        input [31:0] data;
        
        begin
          for (c=0; c<49 ; c=c+1) begin
            if (mem[c][0] == addr) begin
              $display ("WRITE Addr FOUND!: %h" , mem[c][0]);
              mem[c][1] = data;
              addr_found = 1;
            end
          end
          if (addr_found==0) begin // new addition to RAM
            mem[ram_size][0] = addr;
            mem[ram_size][1] = data;
            ram_size = ram_size+1;
            addr_found = 1;
          end
        end
      endtask
      
      // read from RAM
      task readRAM;
        input [31:0] addr;
        output [31:0] data;
        begin
          for (c=0; c<49 ; c=c+1) begin
            if (mem[c][0] == addr) begin
              $display ("READ Addr FOUND!: %h" , mem[c][0]);
              data = mem[c][1];
            end
          end
        end
      endtask
        

  always @(negedge clk)
    begin
      
      if (initNeeded==1) begin
        $display("Now initializing sram");
        initiate;
        initNeeded=0;
      end
    // for debugging if the ram is initiated display its addr and word
      if ((initNeeded==0) && (check_sram==0)) begin
        checkRAM;
        check_sram=1;
      end
    
    // starting read/write  
      
      if ((initNeeded==0) && (cs==1)) begin
        if (we==1) begin
          addr_found = 0;
          writeRAM(addr , din);
        end
        if (oe==1) begin
          readRAM(addr , dbuf);
          $display("Writing to dout: " , dbuf);
          dout = dbuf;
        end
      end
   end

  always @(*) begin
    if ((initNeeded==0) && (cs==1)) begin
      if (oe==1) begin
          readRAM(addr , dbuf);
          $display("Writing to dout: " , dbuf);
          dout = dbuf;
        end
    end
  end
   
endmodule
