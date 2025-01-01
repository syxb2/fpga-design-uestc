`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/tx_uart.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/rx_uart.v"
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task6_uart/mod/ctrl_uart.v"

module top_tb();
    // 定义信号
    reg clk;
    reg rst;
    reg rx_in;
    wire rx_ready;
    wire[7:0] rx_data;
    wire tx_ready;
    wire[7:0] tx_data;
    wire tx_out;

    // 实例化被测试模块
    rx_uart u_rx(
        .clk(clk),
        .rst(rst),
        .rx(rx_in),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    ctrl_uart u_ctrl(
        .clk(clk),
        .rst(rst),
        .rx_ready(rx_ready),
        .rx_data(rx_data),
        .tx_ready(tx_ready),
        .tx_data(tx_data)
    );

    tx_uart u_tx(
        .clk(clk),
        .rst(rst),
        .tx(tx_out),
        .tx_data(tx_data),
        .tx_ready(tx_ready)
    );

    // 时钟生成
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_tb);
        clk = 0;
        forever #10 clk = ~clk;
    end

    // 测试激励
    initial begin
        // 初始化
        rst = 1;
        
        // 复位
        #20 rst = 0;
        #20 rst = 1;
        
        // 等待一段时间
        #100;

        // Send a byte (0x00) over rx line
        send_byte(8'h00);
        // Wait for reception to complete
        #1000000;

        // Send another byte (0x73) over rx line
        send_byte(8'h73);
        // Wait for reception to complete
        #1000000;

        // Send a byte (0x00) over rx line
        send_byte(8'h00);
        // Wait for reception to complete
        #1000000;

        // Send another byte (0x0A) over rx line
        send_byte(8'h0A);
        // Wait for reception to complete
        #1000000;

        // 等待运算和发送完成
        #5000000;

        // End simulation
        $stop;
    end

    // Task to send a byte over rx line
    task send_byte(input[7:0] data);
        integer i;
        begin
            // Send start bit
            rx_in = 0;
            #104160; // Wait for one bit period

            // Send data bits
            for (i = 0; i < 8; i = i + 1) begin
                rx_in = data[i];
                #104160; // Wait for one bit period
            end

            // Send stop bit
            rx_in = 1;
            #104160; // Wait for one bit period
        end
    endtask
endmodule
