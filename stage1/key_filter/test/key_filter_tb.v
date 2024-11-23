`timescale 1ns/1ns

module key_filter_tb();
    reg clk;
    reg rst;
    reg in;
    wire out;

    key_filter uut(
        .clk    (clk),
        .rst    (rst),
        .in     (in),
        .out    (out)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, key_filter_tb);

        rst = 1;
        #20 rst = 0;
        in = 0;
        #20 rst = 1;
        #30 in = 1;
        #40 in = 0;
        #50 in = 1;
        #60 in = 0;

        #10000000 $finish;
    end
endmodule
