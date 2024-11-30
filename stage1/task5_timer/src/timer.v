/**
 * @brief 计时器
 */
module timer(clk, rst, out);
    input clk;
    input rst;
    output reg[5:0][3:0] out;

    reg [23:0] counter;
endmodule
