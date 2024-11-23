`timescale 1ns/1ns //第一个是时间单位，第二个是时间精度
`include "/Users/baijiale/Documents/Code/fpga_design_uestc/decoder_3_8/src/decoder_3_8.v"

module decoder_3_8_tb; //由于这是仿真文件所以不需要写模块端口号
    //开始例化
    reg s_a,s_b,s_c; //定义s_a,s_b,s_c为reg信号
    wire [7:0] s_out; //定义s_out为wire信号

    decoder_3_8 decoder_3_8(
        .a      (s_a),
        .b      (s_b), //这里的s_a,s_b,s_c,s_out都是仿真文件中的信号
        .c      (s_c), //a,b,c都是激励信号，都要设计成reg信号
        .out    (s_out) //out是要被观测的信号，定义成wire类型
    );

    //结束例化
    //开始产生激励
    initial begin
        s_a = 0; s_b = 0; s_c = 0; //初始化信号
        #200 s_a = 0; s_b = 0; s_c = 1; //200ns后，s_a = 0; s_b = 0; s_c = 1;
        #200 s_a = 0; s_b = 1; s_c = 0; //200ns后，s_a = 0; s_b = 1; s_c = 0;
        #200 s_a = 0; s_b = 1; s_c = 1; //200ns后，s_a = 0; s_b = 1; s_c = 1;
        #200 s_a = 1; s_b = 0; s_c = 0; //200ns后，s_a = 1; s_b = 0; s_c = 0;
        #200 s_a = 1; s_b = 0; s_c = 1; //200ns后，s_a = 1; s_b = 0; s_c = 1;
        #200 s_a = 1; s_b = 1; s_c = 0; //200ns后，s_a = 1; s_b = 1; s_c = 0;
        #200 s_a = 1; s_b = 1; s_c = 1; //200ns后，s_a = 1; s_b = 1; s_c = 1;
        #2000 $finish;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, decoder_3_8_tb);	// tb的模块名
    end
endmodule

