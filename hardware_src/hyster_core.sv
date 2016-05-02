`define HYS_LVL 4

module hyster_rng
    (input  logic clk_h, clk_l,
     input  logic rst_b, 
     output logic done, rnd_bit);

    logic dff_out[3:0];
    
    logic sample_bit;

    flip_flop df1(.clk(clk_l),
            .rst_b,
            .d(clk_h),
            .q(dff_out[0]));

    generate 
    genvar i;

    for(i=1;i<`HYS_LVL;i++) begin:HYSTER
      flip_flop #(i) dff_gen(.clk(clk_l),
                       .rst_b,
                       .d(dff_out[i-1]),
                       .q(dff_out[i]));
		end
    endgenerate

    assign sample_bit = dff_out[0]^dff_out[1]^
                        dff_out[2]^dff_out[3];

    logic [1:0] count;

    counter #(2) cyc_count(.clk(clk_l),
                           .rst_b,
                           .clr( ),
                           .inc(1'b1),
                           .count);

    logic wr_in;

    assign wr_in = count[1]&count[0];

    /*flip_flop wr_buf(.clk(clk_l),
               .rst_b,
               .d(wr_in),
               .q(done));*/

    assign done = wr_in;

    assign rnd_bit = sample_bit;

endmodule: hyster_rng
