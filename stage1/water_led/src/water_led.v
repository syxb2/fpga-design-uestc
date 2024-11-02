module water_led(clock, reset, led_out);
    parameter CNT_MAX = 32'd100;
    parameter HIGH_LEVEL = 1'b1;
    parameter LOW_LEVEL = 1'b0;

    input wire clock; // clock，board f = 100MHz
    input wire reset; // reset，**if High-Level Reset**

    output reg [3:0] led_out; // output

    reg [31:0] counter; // 32 bit counter
    reg has_count_500ms;

    initial begin
        led_out = 4'b0000;
        counter = 32'd0;
        has_count_500ms = 1'b0;
    end

    // count 0.5s
    always@(posedge clock) begin 
        if (reset == 1'b1) begin // if reset do:
            counter <= 32'd0;
            has_count_500ms <= 1'b0;
        end
        else if (counter == CNT_MAX) begin
            counter <= 32'd0;
            has_count_500ms <= 1'b1;
        end
        else begin
            counter <= counter + 1'b1;
        end
    end

    always@(posedge clock) begin
        if (reset == HIGH_LEVEL) begin //? 为什么一开始一定要先打开 reset
            led_out <= 4'b0001; // 复位时LED初始化
        end
        else if (has_count_500ms == 1'b1) begin
            if (led_out == 4'b1000) begin
                led_out <= 4'b0001; // 如果LED移到最左边，则回到最右边
            end
            else begin
                led_out <= led_out << 1; // 否则LED向左移一位
            end
            has_count_500ms <= 1'b0;
        end
    end
endmodule
