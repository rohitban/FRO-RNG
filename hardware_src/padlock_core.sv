module padlock_core
    (input logic rst_b,
     input logic clk_h, clk_l,
     output logic bit_out, done);
    
   logic clk_sample;
	
	logic vnm_out;

   flip_flop sample(.clk(clk_l),
              .rst_b,
              .d(clk_h),
              .q(clk_sample));

   vnm_corr vnm(.clk(clk_l),
                .rst_b,
                .bit_in(clk_sample),
                .done,
                .bit_out(vnm_out));

	assign bit_out = vnm_out;


endmodule: padlock_core
