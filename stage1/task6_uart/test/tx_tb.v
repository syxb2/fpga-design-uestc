`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/tx_uart.v"

module tx_tb;
    reg clk;
    reg rst;
    reg [7:0] tx_data;
    reg tx_ready;
    wire tx;

    // Instantiate the tx module
    tx_uart uut (
        .clk(clk),
        .rst(rst),
        .tx_data(tx_data),
        .tx_ready(tx_ready),
        .tx(tx)
    );

    // Clock generation
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tx_tb);
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 0;
        tx_data = 8'h00;
        tx_ready = 0;
        #100;
        
        // Reset the design
        rst = 1;
        #100;
        rst = 0;
        #100;
        rst = 1;
        #100;

      #300000;
        // Send a byte (0xA5) over tx line
        tx_data = 8'hA5;
        tx_ready = 1;
        #40
        tx_ready = 0;
        #1500000;

        // Send another byte (0x5A) over tx line
        tx_data = 8'h5A;
        tx_ready = 1;
        #40
        tx_ready = 0;
        #1500000;

        // End simulation
        $stop;
    end
endmodule
