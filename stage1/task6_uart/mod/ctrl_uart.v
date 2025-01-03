/**
 * @brief 控制模块
 */
module ctrl_uart(clk, rst, rx_ready, rx_data, tx_ready, tx_data, y_to_led);
    // parameter TX_CNT = 41664; // 波特率对应周期数 5208 * 8
    parameter TX_CNT = 166576;
    parameter BIT_MAX = 16; // 数据位数

    input wire clk;
    input wire rst;
    input wire rx_ready; // 可以接收标志
    input wire[7:0] rx_data; // 接收到的数据; 8bits
    output reg tx_ready; // 可以发送标志
    output reg[7:0] tx_data; // 要发送的数据; 8bits
    output reg[23:0] y_to_led; // 商

    /* ------------------------------ rx ------------------------------ */

    // rx 相关变量
    reg rx_done; // 接收完成标志
    reg[1:0] rx_cnt;

    reg[BIT_MAX-1:0] a; // 用于存储被除数 16bits
    reg[BIT_MAX-1:0] b; // 用于存储除数 16bits
    reg[BIT_MAX-1:0] y; // 用于存储商; 16bits
    reg[BIT_MAX-1:0] r; // 用于存储余数; 16bits

    initial begin
        rx_done <= 0;
        rx_cnt <= 0;
        tx_cnt <= 0;
        tx_state <= 0;
        tx_ready <= 0;
        tx_done = 1'b0;
        a <= 0;
        b <= 0;
        y <= 0;
        r <= 0;
        y_to_led <= 0;
    end

    // 接收数据计数
    always @(negedge rx_ready or negedge rst) begin
        if (!rst) begin
            rx_cnt <= 0;
        end
        else begin
            if (rx_cnt == 3) begin
                rx_cnt <= 0;
            end
            else begin
                rx_cnt = rx_cnt + 1;
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
                case(rx_cnt)
                    0: begin
                        a[7:0] <= rx_data; // 先接收高8位
                    end
                    1: begin
                        a[15:8] <= rx_data;
                    end
                    2: begin
                        b[7:0] <= rx_data; // 先接收高8位
                    end
                    3: begin
                        b[15:8] <= rx_data;
                        rx_done <= 1;
                    end
                endcase
            end
        end
    end

    /* ------------------------------ devision ------------------------------ */

    // devision 相关变量
    reg d_done;
    reg[2*BIT_MAX-1:0] Ra; // 存储被除数和余数
    reg[BIT_MAX-1:0] Rb; // 存储除数
    reg[BIT_MAX-1:0] Rc; // 存储商
    reg[5:0] d_cnt; // 计数器，用于控制移位次数（最多16次）
    reg[1:0] d_state; // 0 表示空闲；1 表示运行中；2 表示已完成

    always@(posedge clk or posedge rst) begin
        if (!rst) begin
            d_state <= 0;
            d_done <= 0;
            Ra <= 0;
            Rb <= 0;
            Rc <= 0;
            y_to_led <= 0;
        end
        else begin
            case (d_state)
                0: begin
                    d_cnt <= 16;
                    if (rx_done) begin
                        Ra = {16'h0000, a};
                        Rb = b;
                        Rc = 16'h0000;
                        d_state <= 1;
                    end
                end

                1: begin
                    if (d_cnt != 0) begin
                        Ra = Ra << 1;
                        Rc = Rc << 1;

                        if (Ra[31:16] >= Rb) begin
                            Ra[31:16] = Ra[31:16] - Rb;
                            Rc[0] = 1;
                        end
                        else begin
                            Rc[0] = 0;
                        end
                        d_cnt <= d_cnt - 1;
                    end
                    else begin
                        y = Rc;
                        y_to_led[15:0] = Rc;
                        r[15:0] = Ra[31:16];
                        d_state <= 2;
                    end
                end

                2: begin
                    d_done <= 1;
                end
            endcase
        end
    end

    /* ------------------------------ tx ------------------------------ */

    // tx 相关变量
    reg[25:0] tx_cnt; // 计数
    reg end_cnt;
    reg[1:0] tx_state;
    reg tx_done;

    // 发送数据
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            tx_data <= 0;
            tx_state <= 0;
            tx_ready <= 0;
            tx_done <= 0;
            tx_cnt <= 0;
        end
        else if (d_done && !tx_done) begin
            if (tx_cnt == TX_CNT - 1) begin
                tx_cnt <= 0;
                end_cnt = 1;
                tx_ready = 1;
            end
            else begin
                tx_cnt <= tx_cnt + 1;
                end_cnt = 0;
                tx_ready = 0;
            end

            if (end_cnt) begin
                case(tx_state)
                    0: begin // 先发送商低8位
                        tx_data <= y[7:0];
                        tx_state <= 1;
                    end
                    1: begin
                        tx_data <= y[15:8];
                        tx_state <= 2;
                    end
                    2: begin
                        tx_data <= r[7:0];
                        tx_state <= 3;
                    end
                    3: begin
                        tx_data <= r[15:8];
                        tx_done <= 1;
                    end
                endcase
            end
        end
        else if (tx_done) begin
            tx_ready <= 0;
        end
    end
endmodule
