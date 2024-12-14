`timescale 1ns/1ps
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/tx.v"

module tx_tb;
    reg clk;
    reg rst;
    reg [7:0] tx_data;
    wire tx_ready;
    wire tx;

    // Instantiate the tx module
    tx uut (
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
        #1200000;

        // Send another byte (0x5A) over tx line
        tx_data = 8'h5A;
        #1200000;

        // End simulation
        $stop;
    end
endmodule
