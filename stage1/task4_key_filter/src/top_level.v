`timescale 1ns/1ns

module top_level(clk, rst, in, led, out);
    input wire clk;
    input wire rst;
    input wire in;
    output wire led;
    output wire[6:0] out;

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
endmodule
