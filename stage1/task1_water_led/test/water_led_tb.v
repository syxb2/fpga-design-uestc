// tb文件本身没有输入输出，为的是调用源文件的功能进而测试它
`timescale 1ns/1ns

module water_led_tb();
    reg clk;
    reg rst;
    wire[3:0] lout;

    // 例化
    water_led water_led(
        .clock      (clk),
        .reset      (rst),
        .led_out    (lout)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, water_led_tb);

        clk = 1'b1;
        rst = 1'b1;  // 初始化复位为高电平 //? 为什么初始化是一定要 reset 为真
        #50 rst = 1'b0;  // 50ns后释放复位

        #1000 rst = 1'b1;
        #500 rst = 1'b0;
        #20000 $finish;
    end

    always begin
        #5 clk = ~clk; // f = 100MHz, T = 10ns
    end

endmodule
