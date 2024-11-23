/**
 * @brief 4 位按键计数器
 */
module counter (clk, rst, in, out);
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
