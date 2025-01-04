/**
 * Copyright © 2024 Bai Jiale 578767478@qq.com
 * License: MIT
 */
`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task3_divider_16bits_int_seq/mod/divider_seq_board.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task3_divider_16bits_int_seq/mod/led_encoder_board.v"

module divider_seq_board_tb();
    reg clk;
    reg rst;
    reg start;
    wire done;
    wire[15:0] y;
    wire[6:0] out;
    wire led1;
    wire led2;
    wire led3;
    wire led4;

    divider_seq_board uut(
        .clk        (clk),
        .rst        (rst),
        .done       (done),
        .start      (start),
        .y          (y)
    );

    led_encoder_board uut_led(
        .in         (y),
        .out        (out),
        .led1       (led1),
        .led2       (led2),
        .led3       (led3),
        .led4       (led4)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, divider_seq_board_tb);

        clk = 0;
        rst = 0;
        start = 0;
    end

    always begin
        #5 clk = ~clk; //* T = 10ns
    end

    initial begin
        // Test case 1 ---------------------------
        rst = 1; #10; rst = 0;

        start = 1; #10 start = 0;

        wait(done);
        #50
        $finish;
    end
endmodule
