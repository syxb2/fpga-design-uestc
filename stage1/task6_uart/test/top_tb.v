module top_tb();
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
        $dumpvars(0, top_tb);
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
endmodule
