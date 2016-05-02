
module clk_tb;
    logic clk;
    logic rst_b;

    logic clk_out;
    
    clk_div divider(.clk_in(clk),
                    .rst_b,
                    .clk_out);

    initial begin
        clk = 0;
        rst_b = 0;
        rst_b <= 1;
        forever #5 clk = ~clk;
    end

    initial begin
        for(int i = 0;i < 100; i++)
          @(posedge clk);
        $finish;
    end

endmodule: clk_tb

