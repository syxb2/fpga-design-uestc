/**
 * @brief 发射模块
 */
module tx(clk, rst, tx, tx_data, tx_ready);								 
    input wire clk;
    input wire rst;
    input wire[BIT_MAX-1:0] tx_data; // 要发送的数据
    output wire tx_ready; // 发送完成标志
    output reg tx; // 输出

    parameter BPS_MAX = 5208; // 波特率对应周期数
    parameter BIT_MAX = 8; // 数据位数

    // 状态机参数定义
    parameter IDLE = 0; // 空闲
    parameter START = 1; // 起始位
    parameter DATA = 2; // 数据位
    parameter STOP = 3; // 停止位
 
    reg[1:0] state;// 现态
        
    reg[25:0] bps_cnt;
    wire end_bps_cnt;
    reg[3:0] bit_cnt;
    wire end_bit_cnt; // 输出 1 Byte 数据完成标志
 
    reg[BIT_MAX-1:0] temp_data; // 输出数据临时缓存
 
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
                    temp_data <= 0;
                    if (state == IDLE) begin
                        state <= START;
                    end
                end

                START: begin
                    if(end_bit_cnt) begin
                        state <= STOP;
                    end
                end

                STOP: begin
                    state <= IDLE;
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
            if (bit_cnt == BIT_MAX) begin 
                bit_cnt <= 0;
            end
            else begin 
                bit_cnt <= bit_cnt + 1'b1;
            end 
        end
    end 
    assign end_bit_cnt = bit_cnt == BIT_MAX;

    // 数据输出逻辑
    always @(posedge end_bps_cnt) begin
        if (!rst) 
            temp_data <= 0;
        else if (state == START) 
            temp_data[bit_cnt+1] <= tx;
    end

    always @(*) begin 
        case (state)
            IDLE: tx = 1; // 等待：高电平
            START: tx = 0; // 起始：低电平
            DATA: begin
                if (temp_data[bit_cnt])
                    tx= 1;
                else
                    tx = 0;
            end
            STOP: tx = 1; // 停止：高电平
        endcase
    end

    // 输出逻辑
    assign tx_ready = state == IDLE;
endmodule
