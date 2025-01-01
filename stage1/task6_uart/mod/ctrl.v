/**
 * @brief 控制模块
 */
module ctrl(clk, rst, rx_ready, rx_data, tx_ready, tx_data);
    parameter BPS_MAX = 41664; // 波特率对应周期数 5208 * 8
    parameter BIT_MAX = 16; // 数据位数

    input wire clk;
    input wire rst;
    input wire rx_ready; // 可以接收标志
    input wire[7:0] rx_data; // 接收到的数据; 8bits
    output reg tx_ready; // 可以发送标志
    output reg[7:0] tx_data; // 要发送的数据; 8bits

    // rx 相关变量
    reg rx_done; // 接收完成标志
    reg[1:0] rx_counter;

    // tx 相关变量
    reg[25:0] cnt; // 计数
    reg end_cnt;
    reg[1:0] tx_counter;

    reg[BIT_MAX-1:0] Ra; // 寄存器A: 用于存储被除数 16bits
    reg[BIT_MAX-1:0] Rb; // 寄存器B: 用于存储除数 16bits
    reg[BIT_MAX-1:0] Ry; // 寄存器Y: 用于存储商; 16bits
    reg[BIT_MAX-1:0] Rx; // 寄存器X: 用于存储余数; 16bits

    initial begin
        rx_done <= 0;
        rx_counter <= 0;
        cnt <= 0;
        tx_counter <= 0;
        tx_ready <= 0;
        Ra <= 0;
        Rb <= 0;
        Rx <= 0;
    end

    // 接收数据计数
    always @(negedge rx_ready or negedge rst) begin
        if (!rst) begin
            rx_counter <= 0;
        end
        else begin
            if (rx_counter == 3) begin
                rx_counter <= 0;
            end
            else begin
                rx_counter = rx_counter + 1;
            end
        end
    end



    

    // 接收数据
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            rx_done <= 0;
        end
        else begin
            if (rx_ready) begin
                case(rx_counter)
                    0: begin
                        Ra[15:8] <= rx_data; // 先接收高8位
                    end
                    1: begin
                        Ra[7:0] <= rx_data;
                    end
                    2: begin
                        Rb[15:8] <= rx_data; // 先接收高8位
                    end
                    3: begin
                        Rb[7:0] <= rx_data;
                        rx_done <= 1;
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
            tx_ready <= 0;
            cnt <= 0;
        end
        else if (rx_done) begin
            // 8 bits 计数
            if (cnt == BPS_MAX - 1) begin
                cnt <= 0;
                end_cnt <= 1;
                tx_ready <= 1;
            end
            else begin
                cnt <= cnt + 1;
                end_cnt <= 0;
                tx_ready <= 0;
            end

            if (end_cnt) begin
                case(tx_counter)
                    0: begin // 先发送商高8位
                        tx_data <= Ry[15:8];
                        tx_counter <= 1;
                    end
                    1: begin
                        tx_data <= Ry[7:0];
                        tx_counter <= 2;
                    end
                    2: begin
                        tx_data <= Rx[15:8];
                        tx_counter <= 3;
                    end
                    3: begin
                        tx_data <= Rx[7:0];
                        tx_counter <= 0;
                    end
                endcase
            end
        end
    end
endmodule
