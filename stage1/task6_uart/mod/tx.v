/**
 * @brife 发射模块
 */
module tx(clk, rst, tx_data, tx_ready, tx);
    input wire clk;
    input wire rst;
    input wire[DATA_BIT-1:0] tx_data;
    output wire tx_ready;
    output reg tx;

    parameter DATA_BIT = 8; // 数据位
    parameter STOP_BIT = 1;  // 停止位
    parameter BPS_MAX = 9600; // 波特计数最大值

    // 状态机参数定义
    parameter IDLE = 0; // 空闲
    parameter START = 1; // 起始位
    parameter DATA = 2; // 数据位
    parameter STOP = 3; // 停止位

    reg[1:0] state; // 现态
        
    // 状态转移条件      
    wire idle2start;
    wire start2data;
    wire data2stop;
    wire stop2idle;

    reg[25:0] bps_cnt; // 波特率计数
    wire add_bps_cnt;
    wire end_bps_cnt;
    reg[3:0] bit_cnt; // 数据位计数
    wire add_bit_cnt;
    wire end_bit_cnt;
    reg[3:0] BIT_MAX;

    reg[DATA_BIT-1:0] tx_data_r;

    // 时序逻辑描述状态转移
    always @(posedge clk or negedge rst) begin 
        if (!rst) begin
            state <= IDLE;
        end 
        else begin
            case(state)
                IDLE: begin
                    if (idle2start)
                        state <= START;  
                end
                START: begin
                    if (start2data)
                        state <= DATA ;   
                end
                DATA: begin
                    if (data2stop)
                        state <= STOP;   
                end
                STOP: begin
                    if (stop2idle)
                        state <= IDLE;
                end
            endcase
        end
    end
              
    assign idle2start = state == IDLE;
    assign start2data = (state == START) && end_bit_cnt;
    assign data2stop = (state == DATA) && end_bit_cnt;
    assign stop2idle = (state == STOP) && end_bit_cnt;    

    // bps_cnt                    
    always @(posedge clk or negedge rst) begin 
        if (!rst) begin
            bps_cnt <= 'd0;
        end 
        else if (add_bps_cnt) begin 
            if (end_bps_cnt) begin 
                bps_cnt <= 'd0;
            end
            else begin 
                bps_cnt <= bps_cnt + 1'b1;
            end 
        end
    end 
    
    assign add_bps_cnt = state != IDLE;
    assign end_bps_cnt = add_bps_cnt && bps_cnt == BPS_MAX - 1;

    // bit_cnt
    always @(posedge clk or negedge rst) begin 
        if (!rst) begin
            bit_cnt <= 'd0;
        end 
        else if (add_bit_cnt) begin 
            if(end_bit_cnt) begin 
                bit_cnt <= 'd0;
            end
            else begin 
                bit_cnt <= bit_cnt + 1'b1;
            end 
        end
    end 
    
    assign add_bit_cnt = end_bps_cnt;
    assign end_bit_cnt = add_bit_cnt && bit_cnt == BIT_MAX - 1;

    // 计数器复用
    always @(*) begin 
        case (state)
            START: BIT_MAX = 1;
            DATA: BIT_MAX = DATA_BIT;
            STOP: BIT_MAX = STOP_BIT;
        endcase
    end

    // tx时序
    always @(*) begin 
        case (state)
            IDLE: tx = 1; // 等待：高电平
            START: tx = 0; // 起始：低电平
            DATA: begin
                if (tx_data_r[bit_cnt])
                    tx= 1;
                else
                    tx = 0;
            end
            STOP: tx = 1; // 停止：高电平
        endcase
    end

    assign tx_ready = state == IDLE;
endmodule
