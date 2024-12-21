/**
 * @brief 发送模块
 */
module tx(clk, rst, tx, tx_data, tx_ready);
    input wire clk;
    input wire rst;
    input wire[BIT_MAX-1:0] tx_data; // 要发送的数据
    input wire tx_ready; // 可以发送标志
    output reg tx; // 输出

    parameter BPS_MAX = 5208; // 波特率对应周期数
    parameter BIT_MAX = 8; // 数据位数

    // 状态机参数定义
    parameter IDLE = 0; // 空闲
    parameter START = 1; // 跳过起始位
    parameter DATA = 2; // 数据位
    parameter STOP = 3; // 停止位
    reg[1:0] state;// 现态
        
    reg[25:0] bps_cnt;
    wire end_bps_cnt;
    reg[3:0] bit_cnt;
    reg end_bit_cnt; // 输出相应状态的数据完成标志
    reg[3:0] bit_max;
 
    reg[BIT_MAX-1:0] temp_data; // 输入数据临时缓存
    wire flag_n; // 标志位

    assign flag_n = tx_data[0] || tx_data[1] || tx_data[2] || tx_data[3] || tx_data[4] || tx_data[5] || tx_data[6] || tx_data[7];
 
    // 时序逻辑描述状态转移
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
        end 
        else begin
            case(state)
                IDLE: begin
                    bps_cnt <= 0;
                    bit_cnt <= 0;
                    temp_data <= 0;
                    if (flag_n) begin
                        state <= START;
                    end
                end

                START: begin
                    bit_max = 1;
                    temp_data <= tx_data;
                    if (end_bit_cnt) begin
                        state <= DATA;
                    end
                end

                DATA: begin
                    bit_max = BIT_MAX;
                    if (end_bit_cnt) begin
                        bit_cnt <= 0;
                        state <= STOP;
                    end
                end

                STOP: begin
                    bit_max = 1;
                    if (end_bit_cnt) begin
                        bit_cnt <= 0;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    // 数据输出逻辑
    always @(posedge clk) begin 
        case (state)
            IDLE: tx = 1; // 等待：高电平
            START: tx = 0; // 起始：低电平
            DATA: begin
                if (temp_data[bit_cnt]) begin
                    tx= 1;
                end
                else begin
                    tx = 0;
                end
            end
            STOP: tx = 1; // 停止：高电平
        endcase
    end

    // 输出逻辑
    assign tx_ready = state == IDLE;
              
    // bps_cnt                    
    always @(posedge clk or negedge rst) begin 
        if (!rst) begin
            bps_cnt <= 0;
        end 
        else if (state != IDLE) begin 
            if (bps_cnt == BPS_MAX - 1) begin 
                bps_cnt <= 0;
            end
            else begin 
                bps_cnt <= bps_cnt + 1;
            end
        end
    end
    assign end_bps_cnt = bps_cnt == BPS_MAX - 1;

    // bit_cnt
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            bit_cnt <= 0;
            end_bit_cnt <= 0;
        end
        else if (state != IDLE) begin
            if (end_bps_cnt) begin
                if (bit_cnt == bit_max - 1) begin
                    bit_cnt <= 0;
                    end_bit_cnt <= 1;
                end
                else begin
                    bit_cnt <= bit_cnt + 1;
                    end_bit_cnt <= 0;
                end
            end
            else begin
                end_bit_cnt <= 0;
            end
        end
        else begin
            bit_cnt <= 0;
            end_bit_cnt <= 0;
        end
    end
endmodule
