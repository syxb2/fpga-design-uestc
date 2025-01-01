/**
 * @brief 接收模块
 */
module rx(clk, rst, rx, rx_data, rx_ready);		
    parameter BPS_MAX = 5208; // 波特率对应周期数
    parameter BIT_MAX = 8; // 数据位数

    input wire clk;
    input wire rst;
    input wire rx; // 输入
    output wire[BIT_MAX-1:0] rx_data;
    output wire rx_ready;

    // 状态机参数定义
    parameter IDLE = 0; // 空闲
    parameter START = 1; // 跳过起始位
    parameter DATA = 2; // 数据位
    parameter STOP = 3; // 停止位
 
    reg[1:0] state;// 现态
        
    reg[25:0] bps_cnt;
    reg end_bps_cnt;
    reg[3:0] bit_cnt;
    reg end_bit_cnt; // 接收 1 Byte 数据完成标志
    reg[3:0] bit_max;
 
    reg[BIT_MAX-1:0] temp_data; // 输入数据临时缓存
 
    reg rx_r0; // 输入数据同步寄存
    reg rx_r1;
    
    // 输入数据寄存
    always @(posedge clk or negedge rst) begin 
        if (!rst) begin
            rx_r0 <= 1;
            rx_r1 <= 1;
        end 
        else begin 
           rx_r0 <= rx;
           rx_r1 <= rx_r0;
        end 
    end

    // 时序逻辑描述状态转移
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            bps_cnt <= 0;
            bit_cnt <= 0;
            rx_r0 <= 1;
            rx_r1 <= 1;
            temp_data <= 0;
            end_bit_cnt <= 0;
            end_bps_cnt <= 0;
        end 
        else begin
            // bps_cnt 逻辑
            if (state != IDLE) begin 
                if (bps_cnt == BPS_MAX - 1) begin 
                    bps_cnt <= 0;
                    end_bps_cnt <= 1;
                end
                else begin 
                    bps_cnt <= bps_cnt + 1;
                    end_bps_cnt <= 0;
                end
            end
            else begin
                end_bps_cnt <= 0;
            end

            // 状态机逻辑
            case(state)
                IDLE: begin
                    if (!rx) begin
                        state <= START;
                    end
                end

                START: begin
                    bit_max <= 1;
                    if (end_bit_cnt) begin
                        state <= DATA;
                        bit_cnt <= 0;
                        end_bit_cnt <= 0;
                    end
                end

                DATA: begin
                    bit_max <= BIT_MAX;
                    if (end_bit_cnt) begin
                        bit_cnt <= 0;
                        state <= STOP;
                        end_bit_cnt <= 0;
                    end
                end

                STOP: begin
                    bit_max <= 1;
                    if (end_bit_cnt) begin
                        bit_cnt <= 0;
                        state <= IDLE;
                        end_bit_cnt <= 0;
                    end
                end
            endcase

            // bit_cnt 逻辑
            if (end_bps_cnt) begin
                if (state != IDLE) begin 
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

            // 数据接收逻辑
            if (end_bps_cnt && state == DATA) begin
                temp_data[bit_cnt] <= rx_r1;
            end
        end
    end

    // 输出逻辑
    assign rx_ready = state == STOP;
    assign rx_data = (state == STOP) ? temp_data : 0;
endmodule
