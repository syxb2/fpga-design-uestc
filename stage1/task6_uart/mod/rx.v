/**
 * @brief 接收模块
 */
module rx(clk, rst, rx, rx_data, rx_ready);								 
    input wire clk;
    input wire rst;
    input wire rx; // 输入
    output wire[7:0] rx_data;
    output wire rx_ready;

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
    wire end_bit_cnt; // 接收 1 Byte 数据完成标志
 
    reg[7:0] temp_data; // 输入数据临时缓存
 
    reg rx_r0; // 输入数据同步寄存
    reg rx_r1;
    reg rx_r2;
    reg flag_n; // 下降沿监测 确定rx采样时序
    
    // 输入数据寄存（同步打拍）
    always @(posedge clk or negedge rst) begin 
        if (!rst) begin
            rx_r0 <= 1;
            rx_r1 <= 1;
            rx_r2 <= 1;
        end 
        else begin 
           rx_r0 <= rx;
           rx_r1 <= rx_r0;
           rx_r2 <= rx_r1;
        end 
        if ((!rx_r0 && rx_r1) || (rx_r0 && !rx_r1)) begin
            flag_n <= 1;
        end
    end

    // fsm
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
                    rx_r0 <= 1;
                    rx_r1 <= 1;
                    temp_data <= 0;
                    if (flag_n) begin
                        state <= START;
                    end
                end

                START: ;

                DATA: begin
                    if(end_bit_cnt) begin
                        state <= STOP;
                    end
                end

                STOP: begin
                    state <= IDLE;
                    flag_n <= 0;
                end
            endcase
        end
    end
              
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
                bps_cnt <= bps_cnt + 1'b1;
            end
        end
    end
    assign end_bps_cnt = bps_cnt == BPS_MAX - 1;

    // bit_cnt
    always @(posedge end_bps_cnt) begin 
        if (!rst) begin
            bit_cnt <= 0;
        end
        else if (state != IDLE) begin 
            if (bit_cnt == BIT_MAX + 1) begin 
                bit_cnt <= 0;
            end
            else begin 
                bit_cnt <= bit_cnt + 1'b1;
            end 
        end
    end 
    assign end_bit_cnt = bit_cnt == BIT_MAX + 1;

    // 数据接收逻辑
    always @(posedge end_bps_cnt) begin
        if (!rst) 
            temp_data <= 0;
        else if (state == START) 
            state <= DATA;
        else if (state == DATA) 
            temp_data[bit_cnt-1] <= rx_r2;
    end

    // 输出逻辑
    assign rx_ready = state == STOP;
    assign rx_data = (state == STOP) ? temp_data : 0;
endmodule
