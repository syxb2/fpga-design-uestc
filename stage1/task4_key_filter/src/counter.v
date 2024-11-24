/**
 * @brief 1 位 16 进制数按键计数器
 * 
 * Copyright © 2024 Bai Jiale syxb2@qq.com
 * License: MIT
 */
module counter(clk, rst, in, out);
    input wire clk;
    input wire rst;
    input wire in; // 按键输入信号
    output reg[3:0] out; // 输出稳定的按键计数信号

    initial begin
        out = 4'b0000;
    end

    always @(posedge clk) begin
        if (in) begin
            out <= out + 1;
        end
    end
endmodule
