`timescale 1ns / 1ns
// T = 20ns
// f = 50MHz
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task3_devision_16bits_int_seq/mod/devision_seq_led_board.v"

module devision_seq_led_board_tb();
    // 参数定义
    parameter WIDTH = 16;

    // 输入信号
    reg clk;
    reg rst;
    reg start;

    // 输出信号
    wire done;
    wire led1;
    wire led2;
    wire led3;
    wire led4;
    wire [6:0] out;

    // 实例化被测试模块
    devision_seq_led_board uut (
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

    // 时钟生成
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, devision_seq_led_board_tb);
        clk = 0;
        forever #10 clk = ~clk; // 20ns 周期的时钟
    end

    // 初始化输入信号
    initial begin
        // 初始化信号
        rst = 1;
        start = 1;

        // 监视信号变化
        $monitor("time=%0d, rst=%b, start=%b, done=%b, led1=%b, led2=%b, led3=%b, led4=%b", 
                $time, rst, start, done, led1, led2, led3, led4);

        // 复位信号
        #20 rst = 0;
        #20 rst = 1;

        // 开始信号
        #40 start = 0;
        #20 start = 1;

        // 等待计算完成
        wait(done);

        // 结束仿真
        #3000000 $finish;
    end

endmodule
