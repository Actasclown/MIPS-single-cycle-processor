`include "../lib/dffr_a.v"

module dffr_a_32 (clk, arst, aload, adata, d, enable, q);
    input clk;
    input arst;
    input aload;
    input [31:0] adata;
    input  [31:0] d;
    input enable;
    output [31:0] q;


    genvar i;
    generate
        for(i = 0;i < 32;i = i + 1) begin
            dffr_a dffr_a_0(
                .clk             (clk),
                .arst           (arst),
                .aload       (aload),
                .adata        (adata[i]),
                .d      (d[i]),
                .q      (q[i]),
                .enable   (enable)
            );
        end
    endgenerate


    
    // always @(clk or arst or aload)
    //   begin
    //     if (arst == 1'b1) q <= 0'b0;
    //     else if (aload == 1'b1) q <= adata; 
    //     else if ((clk == 1'b1) && (enable == 1'b1)) q <= d;
    //   end
      
endmodule 
          
    
    
