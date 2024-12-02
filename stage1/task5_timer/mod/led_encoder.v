/**
 * @brief 6 digits decimal(十进制) system LED encoder module
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
    input wire[23:0] in; // 4 bits per digit; 6 digits array
    output reg[6:0] out; // 7 segments display
    output reg[5:0] dig; // 6 bits digits select

    reg[2:0] bits_select;
    reg[15:0] counter;

    initial begin
        bits_select = 0;
        counter = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (!rst) begin
            bits_select <= 0;
            counter <= 0;
        end
        else begin
            if (counter < 50000) begin // 50000 个时钟周期 (1 ms) 后 bits_select + 1
                counter = counter + 1;
            end
            else begin
                counter <= 0;
                if (bits_select == 5) begin
                    bits_select <= 0;
                end
                else begin
                    bits_select <= bits_select + 1;
                end
            end 
        end
    end

    always @(posedge clk) begin
        case(bits_select)
            0: begin
                dig[0] = 1'b1; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b0;
                case(in[3:0])
                    4'b0000: out = 7'b1000000; // 0 - 40H
                    4'b0001: out = 7'b1111001; // 1 - 79H
                    4'b0010: out = 7'b0100100; // 2 - 24H
                    4'b0011: out = 7'b0110000; // 3 - 30H
                    4'b0100: out = 7'b0011001; // 4 - 19H
                    4'b0101: out = 7'b0010010; // 5 - 12H
                    4'b0110: out = 7'b0000010; // 6 - 2H
                    4'b0111: out = 7'b1111000; // 7 - 78H
                    4'b1000: out = 7'b0000000; // 8 - 0H
                    4'b1001: out = 7'b0010000; // 9 - 10H
                endcase
            end

            1: begin
                dig[0] = 1'b0; dig[1] = 1'b1; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b0;
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
                endcase
            end

            2: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b1; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b0;
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
                endcase
            end

            3: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b1; dig[4] = 1'b0; dig[5] = 1'b0;
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
                endcase
            end

            4: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b1; dig[5] = 1'b0;
                case(in[19:16])
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

            5: begin
                dig[0] = 1'b0; dig[1] = 1'b0; dig[2] = 1'b0; dig[3] = 1'b0; dig[4] = 1'b0; dig[5] = 1'b1;
                case(in[23:20])
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
