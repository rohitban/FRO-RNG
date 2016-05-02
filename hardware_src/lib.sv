////OLD_LIB MODULES////

//Parallel in parallel out
module pipo_reg
  #(WIDTH = 8)
   (input logic [WIDTH-1:0] D,
    input logic load, clk, clr,
    output logic [WIDTH-1:0] Q);

    always_ff @(posedge clk) begin
      if (clr)
        Q <= 'd0;
      else if (load)
        Q <= D;
    end

endmodule: pipo_reg


//Parallel in with serial out and parallel out
module piso_reg
  #(WIDTH = 8)
   (input logic  [WIDTH-1:0] D,
    input logic  load, shift, clk, clr,
    output logic [WIDTH-1:0] Q,
    output logic out);
        

    assign out = Q[0];
              
    always_ff @(posedge clk) begin
      if (clr)
        Q <= 'd0;
      else if (load)
        Q <= D;
      else if (shift)
        Q <=  Q >> 1 | 1'b0;
    end      

endmodule: piso_reg


//Serial in Parallel out
module sipo_reg
  #(WIDTH = 8)
   (input logic  d_in, clk, clr, en,
    output logic [WIDTH-1:0] Q);
    logic [WIDTH-1:0]        D;
           
    always_ff @(posedge clk) begin
     if (en & ~clr)
      Q <= {d_in, Q[WIDTH-1:1]};
     else if (clr)
      Q <= 'b0;
    end

endmodule: sipo_reg


module alt_counter
  #(WIDTH = 8)
   (input logic en, clr, clk,
    output logic [WIDTH-1:0] Q);
    logic [WIDTH-1:0]        Qup;
              
    always_ff @(posedge clk) begin
      if (clr)
        Q <= 'b0;
      else if (en)
        Q <= Qup;
    end // always_ff @ (posedge clk)

    assign Qup = Q + 1'd1;

endmodule: alt_counter


module mux
  (input logic D0, D1, sel,
   output logic Y);

   always_comb begin
     if(sel)
       Y = D1;
     else
       Y = D0;
     end

endmodule: mux

//////////////////////


//Basic D flip flop
module flip_flop
    #(parameter id=0)
    (input logic clk, rst_b,
     input logic d,
     output logic q);

    always_ff@(posedge clk, negedge rst_b)
        if(~rst_b)
          q <= 0;
        else
          q <= d;
     
endmodule: flip_flop

module inv_clk
    #(parameter num_inv=7) 
    (input  logic rst_b,
     output logic clk);
    
    logic enable;

    assign enable = rst_b;

    logic [num_inv:0] inv_out/* synthesis keep*/;

    assign inv_out[0] = enable&clk;

    generate
    genvar i;
    for(i=1;i<=num_inv;i++) begin: CHAIN
      not n_gen(inv_out[i],inv_out[i-1]) /* synthesis keep */;
    end
    endgenerate

    assign clk = inv_out[num_inv];

endmodule: inv_clk

module counter
    #(parameter w=2)
    (input logic clk,rst_b,
     input logic clr, inc,
     output logic [w-1:0] count);

    always_ff@(posedge clk, negedge rst_b)
      if(~rst_b)
        count <= 'd0;
      else if(clr)
        count <= 'd0;
      else if(inc)
        count <= count+'d1;


endmodule: counter

//Variable width register
module register
  #(parameter w=1)
  (input  logic         clk, rst_b,
   input  logic [w-1:0] d,
   input  logic         ld, clr,
   output logic [w-1:0] q);

  always_ff@(posedge clk, negedge rst_b)
    if(~rst_b)
      q <= 0;
    else if(clr)
      q <= 0;
    else if(ld)
      q <= d;
    
endmodule: register


//Clock divider
module clk_div
    #(parameter val = 'd7, bits = 'd3)
    (input logic clk_in, rst_b,
     output logic clk_out);

    logic [bits-1:0] count;

    always_ff@(posedge clk_in, negedge rst_b)
        if(~rst_b) begin
          count <= 0;
          clk_out <= 0;
        end
        else if(count >= val) begin
          count <= 0;
          clk_out <= ~clk_out;
        end
        else
          count <= count + 1;

endmodule: clk_div

//Von Neumann corrector
module vnm_corr
    (input logic clk,//fast input clk
     input logic rst_b,
     input logic bit_in,
     output logic done,
     output logic bit_out);

    logic past_bit;

    flip_flop past(.clk, 
             .rst_b,
             .d(bit_in),
             .q(past_bit));

    always_comb begin
        done = 1'b1;
        if(bit_in==past_bit) begin
          bit_out = bit_in;
          done = 1'b0;
        end
        else if(past_bit == 1)
          bit_out = 1'b1;
        else
          bit_out = 1'b0;
    end

endmodule: vnm_corr
