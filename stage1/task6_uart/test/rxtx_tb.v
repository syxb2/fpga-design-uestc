`timescale 1ns/1ps
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/rx.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/tx.v"

module rxtx_tb;
    reg clk;
    reg rst;
    reg [7:0] tx_data;
    reg tx_ready;
    wire tx;
    wire [7:0] rx_data;
    wire rx_ready;

    // Instantiate the tx module
    tx tx_inst (
        .clk(clk),
        .rst(rst),
        .tx_data(tx_data),
        .tx_ready(tx_ready),
        .tx(tx)
    );

    // Instantiate the rx module
    rx rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(tx),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    // Clock generation
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, rxtx_tb);
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

        // Send a byte (0xA5) over tx line
        tx_data = 8'hA5;
        tx_ready = 1;
        #20;
        tx_ready = 0;
        wait(rx_ready);
        #100;

        // Send another byte (0x5A) over tx line
        tx_data = 8'h5A;
        tx_ready = 1;
        #20;
        tx_ready = 0;
        wait(rx_ready);
        #100;

        // End simulation
        $stop;
    end
endmodule
