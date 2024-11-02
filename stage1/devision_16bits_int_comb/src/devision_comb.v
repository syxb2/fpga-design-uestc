/** 
 * 16bits int devision with combinational logic
 * a: dividend
 * b: divisor
 * y: quotient
 * remainder: remiander
 * 
 * 组合逻辑反映在电路上，是十六个子电路串起来的。更加复杂，所以延迟很大。
 * 而时序逻辑是一个电路，里面有一个状态机，根据状态机的状态来决定电路的行为。
 */
module devision_comb(a, b, y, remainder);
    parameter WIDTH = 16;

    input wire[WIDTH-1:0] a;
    input wire[WIDTH-1:0] b;
    output reg[WIDTH-1:0] y;
    output reg[WIDTH-1:0] remainder;

    reg[2*WIDTH-1:0] Ra; // 存储被除数和余数
    reg[WIDTH-1:0] Rb; // 存储除数
    reg[WIDTH-1:0] Rc; // 存储商

    integer i;

    initial begin
        Ra = 32'h00000000;
        Rb = 16'h0000;
        Rc = 16'h0000;
    end

    always@(a or b) begin
        Ra[15:0] = a;
        Ra[31:16] = 16'h0000;
        Rb = b;
        Rc = 16'h0000;

        for (i = 0; i < WIDTH; i = i + 1) begin
            Ra = Ra << 1;
            Rc = Rc << 1;

            if (Ra[31:16] >= Rb) begin // 整数除法：扩展被除数的后16位和除数比较。后16位是被除数逐渐左移得到的
                Ra[31:16] = Ra[31:16] - Rb;
                Rc[0] = 1;
            end
            else begin
                Rc[0] = 0;
            end
        end

        y = Rc;
        remainder = Ra[31:16];
    end
endmodule
