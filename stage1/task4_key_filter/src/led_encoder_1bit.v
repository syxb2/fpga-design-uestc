/**
 * Copyright © 2024 Bai Jiale 578767478@qq.com
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
            out <= 7'b0111111;
        end
        else begin
            case(in[3:0])
                4'b0000: out = 7'b0111111; // 0
                4'b0001: out = 7'b0000110; // 1
                4'b0010: out = 7'b1011011; // 2
                4'b0011: out = 7'b1001111; // 3
                4'b0100: out = 7'b1100110; // 4
                4'b0101: out = 7'b1101101; // 5
                4'b0110: out = 7'b1111101; // 6
                4'b0111: out = 7'b0000111; // 7
                4'b1000: out = 7'b1111111; // 8
                4'b1001: out = 7'b1101111; // 9
                4'b1010: out = 7'b1110111; // A
                4'b1011: out = 7'b1111100; // b
                4'b1100: out = 7'b0111001; // C
                4'b1101: out = 7'b1011110; // d
                4'b1110: out = 7'b1111001; // E
                4'b1111: out = 7'b1110001; // F
            endcase
        end
    end
endmodule
