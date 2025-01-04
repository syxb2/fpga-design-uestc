/**
 * Copyright © 2024 Bai Jiale 578767478@qq.com
 * License: MIT
 */
`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task3_divider_16bits_int_seq/mod/divider_seq.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task3_divider_16bits_int_seq/mod/led_encoder.v"

module divider_seq_tb();
    reg clk;
    reg rst;
    reg start;
    wire done;
    reg[15:0] a;
    reg[15:0] b;
    wire[15:0] y;
    wire[15:0] remainder;
    wire[6:0] out1;
    wire[6:0] out2;
    wire[6:0] out3;
    wire[6:0] out4;

    divider_seq uut(
        .clk        (clk),
        .rst        (rst),
        .start      (start),
        .done       (done),
        .a          (a),
        .b          (b),
        .y          (y),
        .remainder  (remainder)
    );

    led_encoder uut_led(
        .in         (y),
        .out1       (out1),
        .out2       (out2),
        .out3       (out3),
        .out4       (out4)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, divider_seq_tb);

        clk = 0;
        rst = 0;
        start = 0;

        a = 16'h0000;
        b = 16'h0000;
    end

    always begin
        #5 clk = ~clk; //* T = 10ns
    end

    initial begin
        // Test case 1 ---------------------------
        rst = 1; #10; rst = 0;

        a = 16'd110;
        b = 16'd25;

        start = 1; #10 start = 0;

        wait(done); //! 等待 done 信号变为 1 后再继续执行下面的语句
        #50

        // Test case 2 ----------------------------
        rst = 1; #10 rst = 0;

        a = 16'd32200;
        b = 16'd37;

        start = 1; #10 start = 0;
        
        wait(done); 
        #50;

        // Test case 3 -----------------------------
        rst = 1; #10 rst = 0;

        a = 16'd1234;
        b = 16'd56;

        start = 1; #10 start = 0;

        wait(done); 
        #50;

        $finish;
    end
endmodule
