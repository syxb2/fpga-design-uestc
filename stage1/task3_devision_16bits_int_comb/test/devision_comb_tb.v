`timescale 1ns/1ns
// `include "/Users/baijiale/Documents/Code/fpga_design_uestc/devision_16bits_int/src/devision_com.v"

module devision_comb_tb;
    // 参数定义
    parameter WIDTH = 16;

    // 输入信号
    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;

    // 输出信号
    wire [WIDTH-1:0] y;
    wire [WIDTH-1:0] remainder;

    wire[6:0] out1;
    wire[6:0] out2;
    wire[6:0] out3;
    wire[6:0] out4;

    // 实例化被测试模块
    devision_comb uut(
        .a          (a),
        .b          (b),
        .y          (y),
        .remainder  (remainder)
    );

    led_encoder uut_led(
        .in     (y),
        .out1   (out1),
        .out2   (out2),
        .out3   (out3),
        .out4   (out4)
    );

    // 初始化输入信号
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, devision_comb_tb);
        // 打印信号头
        $monitor("time=%0d, a=%d, b=%d, y=%d, remainder=%d", $time, a, b, y, remainder);

        #10;

        // 测试用例1
        a = 16'd100;
        b = 16'd3;
        #10;  // 等待10个时间单位

        // 测试用例2
        a = 16'd50;
        b = 16'd7;
        #10;  // 等待10个时间单位

        // 测试用例3
        a = 16'd200;
        b = 16'd15;
        #10;  // 等待10个时间单位

        // 测试用例4
        a = 16'd1234;
        b = 16'd56;
        #10;  // 等待10个时间单位

        // 测试用例5
        a = 16'd65535;
        b = 16'd255;
        #10;  // 等待10个时间单位

        // 结束仿真
        $finish;
    end

endmodule
