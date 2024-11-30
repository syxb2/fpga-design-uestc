/**
 * @brief 
     * 6 digits decimal system LED encoder module
 * @in
     * clk: clock signal
     * rst: reset signal
     * in: 6 digits array with 4 bits per digit
 * @out
     * out: 7 segments display
     * dig: 6 bits digits select
 * 
 */
module led_encoder(clk, rst, in, out, dig);
    input wire clk;
    input wire rst;
    input wire[5:0][3:0] in; // 4 bits per digit; 6 digits array
    output reg[6:0] out; // 7 segments display
    output reg[5:0] dig; // 6 bits digits select

    reg[2:0] bits_select;

    always@(posedge clk) begin
        case(bits_select)
            3'b000: begin
                dig[0] = 1'b1; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b0;
                case(in[0][3:0])
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
                endcase
            end

            3'b001: begin
                dig[0] = 1'b0; dig[1] = 1'b1; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b0;
                case(in[1][3:0])
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
                endcase
            end

            3'b010: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b1; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b0;
                case(in[2][3:0])
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
                endcase
            end

            3'b011: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b1; dig[4] = 1'b0; dig[5] = 1'b0;
                case(in[3][3:0])
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
                endcase
            end

            3'b100: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b1; dig[5] = 1'b0;
                case(in[4][3:0])
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
                endcase
            end

            3'b101: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b1;
                case(in[5][3:0])
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
                endcase
            end
        endcase
    end
endmodule