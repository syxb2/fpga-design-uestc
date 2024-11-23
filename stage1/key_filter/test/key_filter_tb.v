`timescale 1ns/1ns

module key_filter_tb();
    reg clk;
    reg rst;
    reg in;
    wire[6:0] out;
    wire filter_out;
    wire[3:0] count;

    key_filter filter(
        .clk    (clk),
        .rst    (rst),
        .in     (in),
        .out    (filter_out)
    );

    counter counter(
        .clk    (clk),
        .rst    (rst),
        .in     (filter_out),
        .out    (count)
    );

    led_encoder_1bit led1(
        .clk    (clk),
        .rst    (rst),
        .in     (count),
        .out    (out),
        .led    (led)
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

        #3000

        #30 in = 1;
        #40 in = 0;
        #50 in = 1;
        #60 in = 0;

        #3000

        #30 in = 1;
        #40 in = 0;
        #50 in = 1;
        #60 in = 0;

        #10000000 $finish;
    end
endmodule
