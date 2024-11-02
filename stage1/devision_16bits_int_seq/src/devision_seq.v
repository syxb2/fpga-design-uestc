/**
 *  16bits int devision with sequential logic
 */
module devision_seq(clk, rst, start, done, a, b, y, remainder);
    parameter WIDTH = 16;

    input wire clk;
    input wire rst; // 重置信号，初始化寄存器
    input wire start; // 开始信号
    output reg done;

    input wire[WIDTH-1:0] a;
    input wire[WIDTH-1:0] b;
    output reg[WIDTH-1:0] y;
    output reg[WIDTH-1:0] remainder;

    reg[2*WIDTH-1:0] Ra; // 存储被除数和余数
    reg[WIDTH-1:0] Rb; // 存储除数
    reg[WIDTH-1:0] Rc; // 存储商
    reg[5:0] count; // 计数器，用于控制移位次数（最多16次）
    reg[1:0] state; // 0 表示空闲；1 表示运行中；2 表示已完成

    initial begin
        state = 1'b0;
        done = 1'b0;
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
