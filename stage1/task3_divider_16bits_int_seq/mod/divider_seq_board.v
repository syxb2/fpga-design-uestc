/**
 * 16bits int divider with sequential logic
 * 
 * Copyright © 2024 Bai Jiale 578767478@qq.com
 * License: MIT
 */
module divider_seq_board(clk, rst, start, done, y);
    parameter WIDTH = 16;

    input wire clk;
    input wire rst; // 重置信号，初始化寄存器
    input wire start; // 开始信号
    output reg done;

    output reg[WIDTH-1:0] y;
    reg[WIDTH-1:0] remainder;

    reg[WIDTH-1:0] a;
    reg[WIDTH-1:0] b;
    reg[2*WIDTH-1:0] Ra; // 存储被除数和余数
    reg[WIDTH-1:0] Rb; // 存储除数
    reg[WIDTH-1:0] Rc; // 存储商
    reg[5:0] count; // 计数器，用于控制移位次数（最多16次）
    reg[1:0] state; // 0 表示空闲；1 表示运行中；2 表示已完成

    initial begin
        state = 1'b0;
        done = 1'b0;
        a = 16'd32200;
        b = 16'd37;
    end

    always@(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 0;
            done <= 0;
            y <= 0;
            remainder <= 0;
        end
        else begin
            case (state)
                0: begin
                    count <= 16;
                    if (start) begin
                        Ra = {16'h0000, a};
                        Rb = b;
                        Rc = 16'h0000;
                        state <= 1;
                    end
                end

                1: begin
                    if (count != 0) begin
                        Ra = Ra << 1;
                        Rc = Rc << 1;

                        if (Ra[31:16] >= Rb) begin
                            Ra[31:16] = Ra[31:16] - Rb;
                            Rc[0] = 1;
                        end
                        else begin
                            Rc[0] = 0;
                        end
                        count <= count - 1;
                    end
                    else begin
                        y = Rc;
                        remainder = Ra[31:16];
                        state <= 2;
                    end
                end

                2: begin
                    done <= 1;
                    state <= 0;
                end
            endcase
        end
    end
endmodule
