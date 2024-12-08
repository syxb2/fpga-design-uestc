/**
 * @brief 接收模块
 */
module rx_uart(clk, rst, rx, rx_data, rx_ready);								 
    input wire clk;
    input wire rst;
    input wire rx;
    output wire[DATA_BIT-1:0] rx_data;
    output wire rx_ready;

    parameter DATA_BIT = 8; // 数据位
    parameter STOP_BIT = 1; // 停止位
    parameter BPS_MAX = 9600; // 波特计数最大值

    // 状态机参数定义
    parameter IDLE = 0; // 空闲
    parameter START = 1; // 起始位
    parameter DATA = 2; // 数据位
    parameter STOP = 3; // 停止位
 
    reg[1:0] state;// 现态
        
    // 状态转移条件      
    wire idle2start;
    wire start2data;
    wire data2stop;
    wire stop2idle;
        
    reg[25:0] bps_cnt;
    wire add_bps_cnt;
    wire end_bps_cnt;
    reg[3:0] bit_cnt;
    wire add_bit_cnt;
    wire end_bit_cnt;
    reg[3:0] BIT_MAX;
 
    reg[DATA_BIT-1:0] temp_data; // 输入数据零时缓存
 
    reg rx_r0; // 输入数据同步寄存
    reg rx_r1;
    wire flag_n; // 下降沿监测 确定rx采样时序
    
    // 输入数据寄存（同步打拍）
    always @(posedge clk or negedge rst) begin 
        if(!rst)begin
            rx_r0 <= 0;
            rx_r1 <= 0;
        end 
        else begin 
           rx_r0 <= rx;
           rx_r1 <= rx_r0;
        end 
    end

    // 下降沿标志
    assign  flag_n = !rx_r0 && rx_r1;

    // 数据接收逻辑
    always @(posedge clk or negedge rst) begin
        if (!rst) 
            temp_data <= 0;
        else if (state == DATA && bps_cnt == BPS_MAX >> 1) 
            temp_data[bit_cnt] <= rx_r0;
    end

    // fsm
    // 时序逻辑描述状态转移
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
        end 
        else begin
            case(state)
                IDLE: if(idle2start) state <= START;  
                START: if(start2data) state <= DATA ;   
                DATA: begin
                    if (data2stop) state <= STOP ;   
                end
                STOP: if(stop2idle ) state <= IDLE ;    
            endcase
        end
    end
              
    assign idle2start = state == IDLE && flag_n;
    assign start2data = state == START && end_bit_cnt;
    assign data2stop = state == DATA && end_bit_cnt;
    assign stop2idle = state == STOP && end_bit_cnt;    

    // bps_cnt                    
    always @(posedge clk or negedge rst) begin 
       if (!rst) begin
            bps_cnt <= 0;
        end 
        else if (add_bps_cnt) begin 
            if (end_bps_cnt) begin 
                bps_cnt <= 0;
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
            bit_cnt <= 0;
        end 
        else if (add_bit_cnt) begin 
            if (end_bit_cnt) begin 
                bit_cnt <= 0;
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
 
    // 输出逻辑           
    assign rx_ready = state == IDLE;
    assign rx_data = (state == STOP && bit_cnt == STOP_BIT - 1) ? temp_data : 0;
endmodule
