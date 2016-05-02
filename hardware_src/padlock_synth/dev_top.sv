

module dev_top
    (input  logic [1:0] KEY,
     //input  logic       CLOCK_50,
     output logic [2:0] GPIO,
     output logic [0:0] LEDR,
     output logic [1:0] LEDG);
	  
	  

      logic rnd_bit, done, ld;
	 
      logic rst_b, clk;
		
		logic clk_l;

      assign rst_b = KEY[0];

      //Status bit
      assign LEDG[0] = ~KEY[0];

      assign ld = ~KEY[1]&done;

      assign LEDG[1] = ~KEY[1];
        
	  padlock_top dut(.rst_b,
					      .rnd_bit,
                     .clk_h(clk),
							.clk_l,
					      .done);

      register #(1) rnd_reg(.clk,
                            .rst_b,
                            .d(rnd_bit),
                            .ld,
                            .clr( ),
                            .q(LEDR[0]));
      
		assign GPIO[2] = done;
		assign GPIO[1] = rnd_bit;
		assign GPIO[0] = clk_l;
		
      //Only want tx, not rx
      /*uart #(.CLOCK(50000000), .BAUD(9600)) ser1(.new_data(done),
                                                 .rx( ),
                                                 .clk(CLOCK_50),
                                                 .rst(~rst_b),
                                                 .data_in({7'b0,rnd_bit}),
                                                 .data_out( ),
                                                 .tx(GPIO[0]),
                                                 .data_ready( ));*/


	  
							
endmodule: dev_top
