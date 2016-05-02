`define ITERS 10000

module tb;
    logic rst_b;
    
    logic rnd_bit, done;

    //logic rnd_bit, done;

    padlock_top dut(.rst_b,
                    .rnd_bit,
                    .done);

    initial begin
        rst_b = 0;
        rst_b <= #20 1;
    end

    initial begin
        for(int i = 0; i < `ITERS;i++)
          #20;
        $finish;
    end

endmodule:tb
