/**
 * Copyright © 2024 Bai Jiale syxb2@qq.com
 * License: MIT
 */
module led_encoder(in, out, led1, led2, led3, led4);
    input wire[15:0] in;
    output reg[6:0] out;
    output reg led1;
    output reg led2;
    output reg led3;
    output reg led4;

    initial begin
        led1 = 1'b0;
        led2 = 1'b0;
        led3 = 1'b0;
        led4 = 1'b0;
    end

    always@(in) begin
        led1 = 1'b1; led2 = 1'b0; led3 = 1'b0; led4 = 1'b0;
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

        led1 = 1'b0; led2 = 1'b1; led3 = 1'b0; led4 = 1'b0;
        case(in[7:4])
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

        led1 = 1'b0; led2 = 1'b0; led3 = 1'b1; led4 = 1'b0;
        case(in[11:8])
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

        led1 = 1'b0; led2 = 1'b0; led3 = 1'b0; led4 = 1'b1;
        case(in[15:12])
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
endmodule
