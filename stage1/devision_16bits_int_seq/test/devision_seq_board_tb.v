/**
 * Copyright © 2024 Bai Jiale 578767478@qq.com
 * License: MIT
 */
`timescale 1ns/1ns

module devision_seq_board_tb();
    reg clk;
    reg rst;
    reg start;
    wire done;
    reg[15:0] a;
    reg[15:0] b;
    wire[15:0] y;
    wire[15:0] remainder;
    wire[6:0] out;
    wire led1;
    wire led2;
    wire led3;
    wire led4;

    devision_seq_board uut(
        .clk        (clk),
        .rst        (rst),
        .done       (done),
        .start      (start),
        .a          (a),
        .b          (b),
        .y          (y),
        .remainder  (remainder)
    );

    led_encoder uut_led(
        .in         (y),
        .out       (out),
        .led1       (led1),
        .led2       (led2),
        .led3       (led3),
        .led4       (led4)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, devision_seq_board_tb);

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

        wait(done);
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
