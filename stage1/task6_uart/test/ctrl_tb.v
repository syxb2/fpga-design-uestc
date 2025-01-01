`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/ctrl.v"

module ctrl_tb();
    // 定义信号
    reg clk;
    reg rst;
    reg rx_ready;
    reg [7:0] rx_data;
    wire tx_ready;
    wire [7:0] tx_data;

    // 实例化被测试模块
    ctrl u_ctrl(
        .clk(clk),
        .rst(rst),
        .rx_ready(rx_ready),
        .rx_data(rx_data),
        .tx_ready(tx_ready),
        .tx_data(tx_data)
    );

    // 时钟生成
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, ctrl_tb);
        clk = 0;
        forever #10 clk = ~clk;
    end

    // 测试激励
    initial begin
        // 初始化
        rst = 1;
        rx_ready = 0;
        rx_data = 0;
        
        // 复位
        #20 rst = 0;
        #20 rst = 1;
        
        // 等待一段时间
        #100;
        
        // 测试用例1：115 / 10 = 11 ... 5
        // 发送被除数 100 (0x0064)
        rx_ready = 1;
        rx_data = 8'h00;  // 高8位
        #1000000;
        rx_ready = 0;
        rx_data = 0;
        #200;
        rx_ready = 1;
        rx_data = 8'h73;  // 低8位
        #1000000;
        rx_ready = 0;
        rx_data = 0;
        // 发送除数 10 (0x000A)
        #200;
        rx_ready = 1;
        rx_data = 8'h00;  // 高8位
        #1000000;
        rx_ready = 0;
        rx_data = 0;
        #200;
        rx_ready = 1;
        rx_data = 8'h0A;  // 低8位
        #1000000;
        rx_ready = 0;
        rx_data = 0;
        
        // 等待运算和发送完成
        #5000000;
        
        $finish;
    end
    
    // 监视输出
    initial begin
        $monitor("Time=%0t rst=%b rx_ready=%b rx_data=%h tx_ready=%b tx_data=%h",
                 $time, rst, rx_ready, rx_data, tx_ready, tx_data);
    end

endmodule
