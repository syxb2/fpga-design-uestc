`timescale 1ns/1ns

module top_level(input clk, input rst, input start, output wire done, output wire [6:0] out, output wire led1, output wire led2, output wire led3, output wire led4);
    devision_seq_led_board uut(
        .clk    (clk),
        .rst    (rst),
        .start  (start),
        .done   (done),
        .out    (out),
        .led1   (led1),
        .led2   (led2),
        .led3   (led3),
        .led4   (led4)
    );
endmodule
