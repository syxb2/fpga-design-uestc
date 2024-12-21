# task6

## Note

### 1、流程

主机上输入被除数、除数，发送给FPGA，FPGA计算后返回商和余数。

> 参考：https://blog.csdn.net/2301_76461741/article/details/133042197

### 2、alway@(...) 这里一定是 clk，不能使用自己定义的 wire 变量。
