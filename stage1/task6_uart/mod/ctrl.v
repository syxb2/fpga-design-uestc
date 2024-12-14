/**
 * @brief 控制模块
 */
module ctrl(clk, rst, rx_ready, rx_data, tx_data);
    input wire clk;
    input wire rst;
    input wire rx_ready;
    input wire[BIT_MAX-1:0] rx_data;
    output reg[BIT_MAX-1:0] tx_data;

    parameter BIT_MAX = 8; // 数据位数

    reg[BIT_MAX-1:0] Ra; // 寄存器A: 用于存储被除数
    reg[BIT_MAX-1:0] Rb; // 寄存器B: 用于存储除数
    reg[BIT_MAX-1:0] Rx; // 寄存器X: 用于存储商

    // 接收数据
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            tx_data <= 0;
        end
        else begin
            if (rx_ready) begin
                Ra <= rx_data;
            end
        end
    end
endmodule
