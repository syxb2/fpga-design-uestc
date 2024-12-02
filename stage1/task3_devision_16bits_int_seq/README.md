## 任务三

> 此项目已经上板测试完成。

16位无符号整数除法器设计实现 - 时序逻辑

### Release

#### Version 1

```
./devision_seq.v
./led_encoder.v
./test/devision_seq_tb.v
```

#### Version 2

```
./devision_seq_board.v
./led_encoder_board.v
./test/devision_seq_board_tb.v
```

#### Version 3

source files

```
./devision_seq_led_board.v
./test/devision_seq_led_board_tb.v
```

vivado top file

```
./top_level.v
```

vivado constraint file

```
./division_seq.xdc
```

### Usage

make Version 3:

```sh
make
```

注：makefile -- source

```makefile
######################################
# source
######################################
# V sources:
# Version 1
# V_SOURCES = \
# ./test/devision_seq_tb.v \
# ./devision_seq.v \
# ./led_encoder.v

# Version 2
# V_SOURCES = \
# ./test/devision_seq_board_tb.v \
# ./devision_seq_board.v \
# ./led_encoder_board.v

# Version 3
V_SOURCES = \
./test/devision_seq_led_board_tb.v \
./devision_seq_led_board.v
```

### Notes

时序逻辑：也就是把 for 循环换成时钟

* 组合逻辑反映在电路上，是十六个子电路串起来的。更加复杂，所以延迟很大。
* 而时序逻辑是一个电路，里面有一个状态机，根据状态机的状态来决定电路的行为。

#### 关于板子

f = 50MHz
T = 20ns

LED 数码管刷新周期：1ms * 4
