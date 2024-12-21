/**
 * @brief 控制模块
 */
module ctrl(clk, rst, rx_ready, rx_data, tx_data);
    input wire clk;
    input wire rst;
    input wire rx_ready; // 可以接收标志
    input wire[7:0] rx_data; // 接收到的数据; 8bits
    output reg[7:0] tx_data; // 要发送的数据; 8bits

    parameter BIT_MAX = 16; // 总数据位数

    reg done; // 发送数据准备完成标志
    reg rx_counter;
    reg tx_counter;
    reg[BIT_MAX-1:0] Ra; // 寄存器A: 用于存储被除数; 16bits
    reg[BIT_MAX-1:0] Rb; // 寄存器B: 用于存储除数; 16bits
    reg[BIT_MAX-1:0] Rx; // 寄存器X: 用于存储商; 16bits

    // 接收数据
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            tx_data <= 0;
            rx_counter <= 0;
            done <= 0;
        end
        else begin
            if (rx_ready) begin
                case(rx_counter)
                    0: begin
                        Ra[15:8] <= rx_data;
                        rx_counter <= 1;
                    end
                    1: begin
                        Ra[7:0] <= rx_data;
                        rx_counter <= 0;
                    end
                endcase
            end
        end
    end

    // 发送数据
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            tx_data <= 0;
            tx_counter <= 0;
        end
        else begin
            if (done) begin
                case(tx_counter)
                    0: begin
                        tx_data <= Rx[7:0];
                        tx_counter <= 1;
                    end
                    1: begin
                        tx_data <= Rx[15:8];
                        tx_counter <= 0;
                    end
                endcase
            end
        end
    end
endmodule
