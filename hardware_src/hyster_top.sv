module hyster_top
    (input  logic rst_b,
     output logic clk_h,
	  output logic clk_l,
     output logic done, rnd_bit);

	  logic clk_l_a;//, clk_l_b;
	  
    inv_clk #(7) high_clk(.rst_b,
                         .clk(clk_h))/* synthesis keep */;

    inv_clk #(59) low_clka(.rst_b,
                          .clk(clk_l_a))/* synthesis keep */;
	 

	 assign clk_l = clk_l_a;
	
	 
    hyster_rng core(.clk_h,
                    .clk_l,
                    .rst_b,
                    .done,
                    .rnd_bit);


endmodule: hyster_top
