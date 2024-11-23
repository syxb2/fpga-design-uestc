# target
TARGET = vout
# Wave out
WAVE_TARGET = wave.vcd
# Build path
BUILD_DIR = ./build
# V sources:
V_SOURCES = \
./test/key_filter_tb.v \
./src/key_filter.v \
./src/counter.v \
./src/led_encoder_1bit.v
# V includes
# V_INCLUDES =
# binaries
# PREFIX =
# compiler
CC = iverilog
VP = vvp

# default action: build all
all:$(WAVE_TARGET)

$(WAVE_TARGET):$(BUILD_DIR)/$(TARGET).out | $(BUILD_DIR)
	@$(VP) -n $^
$(BUILD_DIR)/$(TARGET).out:$(V_SOURCES) | $(BUILD_DIR)
	@$(CC) -o $@ $(V_SOURCES) 
# $@ 表示 58 行所有内容
$(BUILD_DIR):
	@mkdir $@

.PHONY:help
.PHONY:clean

clean:
	rm Rf wave.vcd $(BUILD_DIR)/*.out
plot:
	@gtkwave wave.vcd
