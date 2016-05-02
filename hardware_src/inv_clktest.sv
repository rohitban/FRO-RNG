

module tb;
   logic rst_b, clk;

   inv_clk #(23) clock_gen(.rst_b,
                           .clk);

   initial begin
    rst_b = 0;
    rst_b <= #100 1;
   end

   initial begin
    #1000000;
    $finish;
   end

endmodule: tb
