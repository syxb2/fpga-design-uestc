/**
 * @brief 1 位数码管编码器
 * 
 * Copyright © 2024 Bai Jiale syxb2@qq.com
 * License: MIT
 */
module led_encoder_1bit(clk, rst, in, out, led);
    input wire[3:0] in;
    input wire clk;
    input wire rst;
    output reg led = 1; // led 位选信号
    output reg[6:0] out; // out 数码管编码输出

    always@(posedge clk) begin
        if (!rst) begin
            out <= 7'b1000000;
        end
        else begin
            case(in[3:0])
                4'b0000: out = 7'b1000000; // 0
                4'b0001: out = 7'b1111001; // 1
                4'b0010: out = 7'b0100100; // 2
                4'b0011: out = 7'b0110000; // 3
                4'b0100: out = 7'b0011001; // 4
                4'b0101: out = 7'b0010010; // 5
                4'b0110: out = 7'b0000010; // 6
                4'b0111: out = 7'b1111000; // 7
                4'b1000: out = 7'b0000000; // 8
                4'b1001: out = 7'b0010000; // 9
                4'b1010: out = 7'b0001000; // A
                4'b1011: out = 7'b0000011; // b
                4'b1100: out = 7'b1000110; // C
                4'b1101: out = 7'b0100001; // d
                4'b1110: out = 7'b0000110; // E
                4'b1111: out = 7'b0001110; // F
            endcase
        end
    end
endmodule
