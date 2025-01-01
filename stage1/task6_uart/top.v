module top(clk, rst, rx_in, tx_out, out, dig);
    // 定义信号
    input wire clk;
    input wire rst;
    input wire rx_in;
    output wire tx_out;
    output wire [6:0] out; // led 编码输出
    output wire [5:0] dig; // 位选信号

    wire rx_ready;
    wire[7:0] rx_data;
    wire tx_ready;
    wire[7:0] tx_data;
    wire[23:0] ten_out;

    // 实例化被测试模块
    rx_uart u_rx(
        .clk(clk),
        .rst(rst),
        .rx(rx_in),
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
        .y_out(ten_out)
    );

    tx_uart u_tx(
        .clk(clk),
        .rst(rst),
        .tx(tx_out),
        .tx_data(tx_data),
        .tx_ready(tx_ready)
    );

    led_encoder u_led_encoder (
        .clk    (clk),
        .rst    (rst),
        .in     (ten_out),
        .out    (out),
        .dig    (dig)
    );
endmodule
