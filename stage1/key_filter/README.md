## 任务四

所有信号都是低电平有效

## Note

### 1、

```verilog
key_filter filter(
    .clk    (clk),
    .rst    (rst),
    .in     (in),
    .out    (filter_out)
);
```

在这句话中：
两个 clk 分别代表不同的东西：
左边的 clk：这是模块 key_filter 的端口名。它定义了模块 key_filter 的一个输入信号，通常是时钟信号。
右边的 clk：这是连接到模块 key_filter 的信号名。它是你在顶层模块中定义的信号，通常也是时钟信号。
