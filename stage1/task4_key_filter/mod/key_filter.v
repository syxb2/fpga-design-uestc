/**
 * @brief 按键滤波模块
 * 
 * Copyright © 2024 Bai Jiale syxb2qq.com
 * License: MIT
 */
module key_filter(clk, rst, in, out);
    input wire clk;
    input wire rst;
    input wire in; // 按键输入信号
    output reg out; // 输出稳定的脉冲信号

    parameter MAX = 20'd1_000_000; // 20ms 计数器最大值

    reg[19:0] cnt_delay; // 20ms 延时计数寄存器
    reg en_cnt_delay; // 20ms 延时计数使能
    reg key_r0; // 同步
    reg key_r1; // 打一拍
    reg key_r2; // 打两拍
    reg nedge; // 下降沿寄存器

    initial begin
        cnt_delay = 0;
        en_cnt_delay = 0;
    end

    // 同步打拍
    always @(posedge clk) begin
        if (!rst) begin // rst 低电平有效
            key_r0 <= 1'b1;
            key_r1 <= 1'b1;
            key_r2 <= 1'b1;
        end
        else begin
            key_r0 <= in; // 同步
            key_r1 <= key_r0; // 寄存一拍
            key_r2 <= key_r1; // 寄存两拍
        end
    end

    // 下降沿检测
    always @(posedge clk) begin
        nedge = ~((~key_r1 && key_r2) || (key_r1 && ~key_r2)); // nedge 为 0 时检测到下降沿
    end

    // 20ms 计数器
    always @(posedge clk) begin
        if (!rst) begin // rst 低电平有效
            cnt_delay <= 1'b0;
            en_cnt_delay <= 1'b0;
        end
        else if (!nedge) begin // nedge 低电平有效
            cnt_delay <= 1'b0;
            en_cnt_delay <= 1'b1;
        end

        // 开始计数
        if (en_cnt_delay) begin
            if (cnt_delay == MAX - 1'b1) begin
                en_cnt_delay <= 1'b0; // 关闭计数
            end
            else begin
                cnt_delay <= cnt_delay + 1'b1;
            end
        end
    end

    // out 脉冲信号赋值
    always @(posedge clk) begin
        if (!rst) begin
            out <= 1'b0;
        end
        else if (cnt_delay == MAX - 2'd2) begin // 计数到最大值减 1 时产生按键脉冲
            out <= ~in; // 不可直接置为 1
        end
        else begin
            out <= 1'b0;
        end
    end
endmodule
