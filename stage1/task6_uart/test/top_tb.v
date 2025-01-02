`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/tx_uart.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/rx_uart.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/ctrl_uart.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/led_encoder.v"

module top_tb();
    // 定义信号
    reg clk;
    reg rst;
    reg in; // 输入数据串行输入
    wire rx_ready; // 接收完成标志
    wire[7:0] rx_data; // 接收到的数据真值
    wire tx_ready; // 可以发送标志
    wire[7:0] tx_data; // 要发送的数据真值
    wire out; // 发送数据串行输出
    wire[23:0] y; // 商的值输出
    wire[6:0] led_out; // led 编码输出
    wire[5:0] dig; // 位选信号

    // 实例化被测试模块
    rx_uart u_rx(
        .clk(clk),
        .rst(rst),
        .rx(in),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    ctrl_uart u_ctrl(
        .clk(clk),
        .rst(rst),
        .rx_ready(rx_ready),
        .rx_data(rx_data),
        .tx_ready(tx_ready),
        .tx_data(tx_data),
        .y_to_led(y)
    );

    tx_uart u_tx(
        .clk(clk),
        .rst(rst),
        .tx(out),
        .tx_data(tx_data),
        .tx_ready(tx_ready)
    );

    led_encoder u_led_encoder(
        .clk    (clk),
        .rst    (rst),
        .in     (y),
        .out    (led_out),
        .dig    (dig)
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
        
        // 复位
        #20 rst = 0;
        #20 rst = 1;
        
        // 等待一段时间
        #1000000;

        // Send a byte (0x00) over rx line
        send_byte(8'h73);
        // Wait for reception to complete
        #1000000;

        // Send another byte (0x73) over rx line
        send_byte(8'h03);
        // Wait for reception to complete
        #1000000;

        // Send a byte (0x00) over rx line
        send_byte(8'h74);
        // Wait for reception to complete
        #1000000;

        // Send another byte (0x0A) over rx line
        send_byte(8'h00);
        // Wait for reception to complete
        #1000000;

        // 等待运算和发送完成
        #30000000;

        // End simulation
        $stop;
    end

    // Task to send a byte over rx line
    task send_byte(input[7:0] data);
        integer i;
        begin
            // Send start bit
            in = 0;
            #104160; // Wait for one bit period

            // Send data bits
            for (i = 0; i < 8; i = i + 1) begin
                in = data[i];
                #104160; // Wait for one bit period
            end

            // Send stop bit
            in = 1;
            #104160; // Wait for one bit period
        end
    endtask
endmodule
