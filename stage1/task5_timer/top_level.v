module top_level(
    input wire clk,
    input wire rst,
    input wire start,
    output wire [6:0] out,
    output wire [5:0] dig
);
    wire [23:0] timer_out;

    // Instantiate the timer module
    timer u_timer (
        .clk    (clk),
        .rst    (rst),
        .start  (start),
        .out    (timer_out)
    );

    // Instantiate the led_encoder module
    led_encoder u_led_encoder (
        .clk    (clk),
        .rst    (rst),
        .in     (timer_out),
        .out    (out),
        .dig    (dig)
    );
endmodule
