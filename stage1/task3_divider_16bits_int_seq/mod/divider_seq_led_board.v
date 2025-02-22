module divider_seq_led_board(clk, rst, start, done, led1, led2, led3, led4, out);
    parameter WIDTH = 16;

    input wire clk;
    input wire rst; // 重置信号，初始化寄存器
    input wire start; // 开始信号
    output reg done;
    output reg led1;
    output reg led2;
    output reg led3;
    output reg led4;
    output reg[6:0] out;

    reg[WIDTH-1:0] a;
    reg[WIDTH-1:0] b;
    reg[WIDTH-1:0] y;
    reg[WIDTH-1:0] remainder;
    reg[2*WIDTH-1:0] Ra; // 存储被除数和余数
    reg[WIDTH-1:0] Rb; // 存储除数
    reg[WIDTH-1:0] Rc; // 存储商
    reg[5:0] count; // 计数器，用于控制移位次数（最多16次）
    reg[1:0] state; // 0 表示空闲；1 表示运行中；2 表示已完成
    reg[1:0] digit_select; // 用于选择当前显示的数码管
    reg[15:0] counter; // 用于计数 50000 个时钟周期

    initial begin
        state = 1'b0;
        done = 1'b0;
        a = 16'h2A5E;
        b = 16'd1;
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
        digit_select = 2'b00;
        counter = 0;
    end

    always@(posedge clk or posedge rst) begin
        if (!rst) begin
            state <= 0;
            done <= 0;
            y <= 0;
            remainder <= 0;
            digit_select <= 2'b00;
            counter <= 0;
        end
        else begin
            if (counter < 50000) begin // 50000 个时钟周期(1 ms)后切换数码管
                counter = counter + 1;
            end
            else begin
                counter <= 0;
                if (digit_select == 2'b11) begin
                    digit_select <= 2'b00;
                end
                else begin
                    digit_select <= digit_select + 1;
                end
            end 

            case (state)
                0: begin
                    count <= 16;
                    if (!start) begin
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

    always@(posedge clk) begin
        case(digit_select)
            2'b00: begin
                led1 = 1'b1; led2 = 1'b0; led3 = 1'b0; led4 = 1'b0;
                case(y[3:0])
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

            2'b01: begin
                led1 = 1'b0; led2 = 1'b1; led3 = 1'b0; led4 = 1'b0;
                case(y[7:4])
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

            2'b10: begin
                led1 = 1'b0; led2 = 1'b0; led3 = 1'b1; led4 = 1'b0;
                case(y[11:8])
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

            2'b11: begin
                led1 = 1'b0; led2 = 1'b0; led3 = 1'b0; led4 = 1'b1;
                case(y[15:12])
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
        endcase
    end
endmodule
