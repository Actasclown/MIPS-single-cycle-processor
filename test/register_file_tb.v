module register_file_tb;

reg clk, rstb;
reg RegWr;                // write_enable; 1-> enable
reg [4:0] Rw, Ra, Rb;     // addr for write, read_a, read_b
reg [31:0] busW;          // data_in
wire [31:0] busA, busB;   // data_out

parameter clk_p = 10;     // clk period


register_file register_file_m1(.clk(clk), .rstb(rstb), .RegWr(RegWr), .Rw(Rw), .Ra(Ra), .Rb(Rb), .busW(busW), .busA(busA), .busB(busB));

initial clk = 1'b1;

always #(clk_p/2) clk = ~clk;

initial begin

    RegWr <= 1'b0;
    Rw <= 5'd0;
    Ra <= 5'd0;
    Rb <= 5'd0;
    busW <= 32'd0;

    rstb <= 1'b1;
    #(clk_p/2)
    rstb <= 1'b0;
    #(clk_p/2)
    rstb <= 1'b1;

    // start writing
    RegWr <= 1'b1;

    Rw <= 5'd23;
    busW <= 32'hff23;
    #clk_p

    Rw <= 5'd17;
    busW <= 32'hff17;
    #clk_p


    Rw <= 5'd0;
    busW <= 32'hff00;
    #clk_p

    Rw <= 5'd31;
    busW <= 32'hff31;
    #clk_p

    // stop writing and starts reading
    RegWr <= 1'b0;

    Ra <= 5'd23;
    Rb <= 5'd0;
    #clk_p

    Ra <= 5'd31;
    Rb <= 5'd17;
    #clk_p

    #(5*clk_p)

    $finish;
end

endmodule