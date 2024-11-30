`timescale 1ns / 1ns

module led_encoder_tb;
    reg clk;
    reg rst;
    reg [5:0][3:0] in;
    wire [6:0] out;
    wire [5:0] dig;

    // Instantiate the led_encoder module
    led_encoder uut(
        .clk    (clk),
        .rst    (rst),
        .in     (in),
        .out    (out),
        .dig    (dig)
    );

    // Clock generation
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, led_encoder_tb);
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        in = 6'b000000;

        // Apply reset
        #20;
        rst = 0;
        #20;
        rst = 1;

        // Test case 1: Display 123456
        in = {4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110};
        #10000000; // Wait for some time to observe the output

        // Finish simulation
        $stop;
    end
endmodule
