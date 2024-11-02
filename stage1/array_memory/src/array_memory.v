module array_memory(data_in, led_out, clock, address, rw, ensure);
    /**
     * rw：读写拨码（0-write，1-read）
     * ensure：确定键
     * data_in：数值拨码
     * address：地址拨码
     * led_out：输出
     * clock：时钟
     */
    parameter width = 4;
    parameter reg_num = 8;
    parameter addr_bits = 3;

    input[width-1:0] data_in;
    input[addr_bits-1:0] address;
    input clock, rw, ensure;
    output[6:0] led_out;

    wire clock, ensure;
    wire[addr_bits-1:0] address;
    reg[width-1:0] memory[0:reg_num-1];
    reg[width-1:0] data_out;
    reg[6:0] led_out;

    always@(posedge clock) begin
    // always@(*) begin
        if (ensure)
            if (rw == 1'b0)
                memory[address] <= data_in;
            else if (rw == 1'b1)
                data_out <= memory[address];

        case(data_out)
            4'b0000: led_out = 7'b0111111; // 0
            4'b0001: led_out = 7'b0000110; // 1
            4'b0010: led_out = 7'b1011011; // 2
            4'b0011: led_out = 7'b1001111; // 3
            4'b0100: led_out = 7'b1100110; // 4
            4'b0101: led_out = 7'b1101101; // 5
            4'b0110: led_out = 7'b1111101; // 6
            4'b0111: led_out = 7'b0000111; // 7
            4'b1000: led_out = 7'b1111111; // 8
            4'b1001: led_out = 7'b1101111; // 9
            4'b1010: led_out = 7'b1110111; // A
            4'b1011: led_out = 7'b1111100; // b
            4'b1100: led_out = 7'b0111001; // C
            4'b1101: led_out = 7'b1011110; // d
            4'b1110: led_out = 7'b1111001; // E
            4'b1111: led_out = 7'b1110001; // F
        endcase
    end
endmodule
