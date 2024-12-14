`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/rx.v"

module rx_tb;
    reg clk;
    reg rst;
    reg rx;
    wire [7:0] rx_data;
    wire rx_ready;

    // Instantiate the rx_uart module
    rx uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    // Clock generation
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, rx_tb);
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 0;
        rx = 1;
        #100;
        
        // Reset the design
        rst = 1;
        #100;
        rst = 0;
        #100;
        rst = 1;
        #100;

        // Send a byte (0xA5) over rx line
        send_byte(8'hA5);

        // Wait for reception to complete
        #140000;

        // Send another byte (0x5A) over rx line
        send_byte(8'h5A);

        // Wait for reception to complete
        #140000;

        // End simulation
        $stop;
    end

    // Task to send a byte over rx line
    task send_byte(input[7:0] data);
        integer i;
        begin
            // Send start bit
            rx = 0;
            #104160; // Wait for one bit period

            // Send data bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #104160; // Wait for one bit period
            end

            // Send stop bit
            rx = 1;
            #104160; // Wait for one bit period
        end
    endtask
endmodule
