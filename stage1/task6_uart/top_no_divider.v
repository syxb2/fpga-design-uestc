/**
 * @brief UART顶层模块
 */
module uart_top(clk, rst, rx, tx);
    input wire clk;
    input wire rst;
    input wire rx; // 接收数据输入
    output wire tx; // 发射数据输入

    wire[7:0] data; // 发送数据输出
    wire ready; // 发送准备好标志

    // 实例化接收模块
    rx rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(rx), // 连接发送模块的输出
        .rx_data(data),
        .rx_ready(ready)
    );

    // 实例化发送模块
    tx tx_inst (
        .clk(clk),
        .rst(rst),
        .tx(tx),
        .tx_data(data),
        .tx_ready(ready)
    );
endmodule
