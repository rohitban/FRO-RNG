module padlock_top
    (input  logic rst_b,
     output logic clk_h,clk_l,
     output logic rnd_bit, done);

    logic clk_l_a, clk_l_b /* synthesis keep */;
    
    inv_clk #(7) high_clk(.rst_b,
                          .clk(clk_h))/* synthesis keep */;

    inv_clk #(59) low_clka(.rst_b,
                           .clk(clk_l_a))/* synthesis keep */;

    inv_clk #(53) low_clkb(.rst_b,
                           .clk(clk_l_b))/* synthesis keep */;
							 
    assign clk_l =  clk_l_a^clk_l_b;
    
    //Set up rng core
    
    padlock_core rng_core(.rst_b,
                          .clk_h,
                          .clk_l,
                          .bit_out(rnd_bit),
                          .done);

endmodule: padlock_top
