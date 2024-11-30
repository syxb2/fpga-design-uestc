`timescale 1ns/1ns

module timer_tb;
    reg clk;
    reg rst;
    reg start;
    wire [5:0][3:0] out;

    // Instantiate the timer module
    timer uut(
        .clk    (clk),
        .rst    (rst),
        .start  (start),
        .out    (out)
    );

    // Generate clock signal
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, timer_tb);
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 0;
        start = 0;
        #100; // Wait for 100 ns

        // Release reset
        rst = 1;
        #100;

        // Start the timer
        start = 1;
        #100000; // Wait for 1 second

        // Stop the timer
        start = 0;
        #100000; // Wait for 1 second

        // Start the timer again
        start = 1;
        #100000; // Wait for 1 second

        // Finish simulation
        $stop;
    end
endmodule