module hyster_dev
	(input  logic [1:0] KEY,
     //input  logic       CLOCK_50,
     output logic [2:0] GPIO,
     output logic [0:0] LEDR,
	 output logic [1:0] LEDG);
	 
     logic rst_b, done, rnd_bit, clk;

     logic ld;
	  
	  logic clk_l;

     assign rst_b = KEY[0];

     assign LEDG[0] = ~KEY[0];

     assign LEDG[1] = ~KEY[1];
    
     //Reg load
     assign ld = done&~KEY[1];

	  assign GPIO[2] = done;
	  assign GPIO[1] = rnd_bit;
	  assign GPIO[0] = clk_l;
	  
	 hyster_top dut(.rst_b,
                   .clk_h(clk),
						 .clk_l,
						 .done,
						 .rnd_bit);
	 
     register #(1) store_reg(.d(rnd_bit),
                             .q(LEDR[0]),
                             .clk,
                             .clr( ),
                             .rst_b,
                             .ld);

      //Only want tx, not rx
      /*uart #(.CLOCK(50000000), .BAUD(9600)) ser1(.new_data(done),
                                                 .rx( ),
                                                 .clk(CLOCK_50),
                                                 .rst(~rst_b),
                                                 .data_in({7'b0,rnd_bit}),
                                                 .data_out( ),
                                                 .tx(GPIO[0]),
                                                 .data_ready( ));*/

endmodule:hyster_dev
