`timescale 1ns/1ns
`include "/Users/baijiale/Documents/Code/fpga-design-uestc/stage1/task2_array_memory/mod/array_memory.v"

module array_memory_tb();
    parameter width = 4;
    parameter reg_num = 8;
    parameter addr_bits = 3;

    reg clk;
    reg[width-1:0] in;
    reg[addr_bits-1:0] addr;
    reg rw, ens;
    wire[6:0] out;

    // 前面的是模块名，后面的是实例名
    array_memory exam(
        .data_in    (in),
        .led_out    (out),
        .clock      (clk),
        .address    (addr),
        .rw         (rw),
        .ensure     (ens)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, array_memory_tb);

        clk <= 1'b0;
        in <= 0;
        addr <= 3'b000;
        ens <= 1;
        rw <= 0; // w

        #10 rw = 1; // r

        #50 rw = 0;

        in <= 4;
        addr <= 3'b001;


        #20000 $finish;
    end

    always begin
        #5 clk = ~clk;
    end
endmodule

