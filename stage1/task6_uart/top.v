module top(clk, rst, in, out, led_out, dig);
    // 定义信号
    input wire clk;
    input wire rst;
    input wire in;
    output wire out;
    output wire [6:0] led_out; // led 编码输出
    output wire [5:0] dig; // 位选信号

    wire rx_ready;
    wire[7:0] rx_data;
    wire tx_ready;
    wire[7:0] tx_data;
    wire[23:0] y;

    wire[23:0] a;

    // 实例化被测试模块
    rx_uart u_rx(
        .clk        (clk),
        .rst        (rst),
        .rx         (in),
        .rx_data    (rx_data),
        .rx_ready   (rx_ready)
    );

    ctrl_uart u_ctrl(
        .clk        (clk),
        .rst        (rst),
        .rx_ready   (rx_ready),
        .rx_data    (rx_data),
        .tx_ready   (tx_ready),
        .tx_data    (tx_data),
        .y_to_led   (y),
        .a          (a)
    );

    tx_uart u_tx(
        .clk        (clk),
        .rst        (rst),
        .tx         (out),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready)
    );

    led_encoder u_led_encoder (
        .clk    (clk),
        .rst    (rst),
        .in     (a),
        .out    (led_out),
        .dig    (dig)
    );
endmodule
