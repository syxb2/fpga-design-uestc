`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task3_divider_16bits_int_seq/mod/divider_seq.v"

module divider_tb;
    reg clk;
    reg rst;
    reg start;
    reg [15:0] a;
    reg [15:0] b;
    wire done;
    wire [15:0] y;
    wire [15:0] remainder;

    // Instantiate the divider_seq module
    divider_seq uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .a(a),
        .b(b),
        .y(y),
        .remainder(remainder)
    );

    // Clock generation
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, divider_tb);
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 0;
        start = 0;
        a = 0;
        b = 0;
        #100;
        
        // Reset the design
        rst = 1;
        #100;
        rst = 0;
        #100;
        rst = 1;
        #100;

        // Test case 1: 100 / 3
        a = 16'd100;
        b = 16'd3;
        start = 1;
        #20;
        start = 0;
        wait(done);
        #100;

        rst = 1;
        #100;
        rst = 0;
        #100;
        rst = 1;
        #100;
        // Test case 2: 255 / 5
        a = 16'd255;
        b = 16'd5;
        start = 1;
        #20;
        start = 0;
        wait(done);
        #100;

        rst = 1;
        #100;
        rst = 0;
        #100;
        rst = 1;
        #100;
        // Test case 3: 1234 / 56
        a = 16'd1234;
        b = 16'd56;
        start = 1;
        #20;
        start = 0;
        wait(done);
        #100;

        // End simulation
        $finish;
    end
endmodule
