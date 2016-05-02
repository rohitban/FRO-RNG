
module clk_dev
    (input  logic [4:0] SW,
     input  logic [1:0] KEY,
     output logic [7:0] LEDG);

	 assign LEDG[7] = ~KEY[0];
	 
	 assign LEDG[6] = ~KEY[1];
	 
	 assign LEDG[5] = SW[4];
	 
	 assign LEDG[4] = 'b0;
	 
    logic ring_clk;

	 
    inv_clk #(59) inv_test(.rst_b(KEY[0]),
                           .clk(ring_clk));
	 
	 
    register #(4) test_reg(.clk(ring_clk),
                           .rst_b(KEY[0]),
                           .d(SW[3:0]),
                           .q(LEDG[3:0]),
                           .clr( ),
                           .ld(~KEY[1]));

endmodule: clk_dev
