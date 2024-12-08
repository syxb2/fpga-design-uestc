# target
TARGET = vout

# Wave out
WAVE_TARGET = wave.vcd

# Build path
BUILD_DIR = ./build

# V sources:
# Version 1
V_SOURCES = \
./test/devision_seq_tb.v \
# Version 2
# V_SOURCES = \
# ./test/devision_seq_board_tb.v \
# Version 3
# V_SOURCES = \
# ./test/devision_seq_led_board_tb.v \

# V includes
# version1
V_INCLUDES = \
./mod/devision_seq.v \
./mod/led_encoder.v \
# version2
# V_INCLUDES = \
# ./mod/devision_seq_board.v \
# ./mod/led_encoder_board.v \
# version3
# V_INCLUDES = \
# ./mod/devision_seq_led_board.v \

# compiler
CC = iverilog
VP = vvp

# binaries
# PREFIX =

# default action: build all
all: $(WAVE_TARGET)

$(WAVE_TARGET): $(BUILD_DIR)/$(TARGET).out
	@$(VP) -n $^
$(BUILD_DIR)/$(TARGET).out: $(BUILD_DIR) $(V_SOURCES) $(V_INCLUDES)
	@$(CC) -o $@ $(V_SOURCES) 
$(BUILD_DIR):
	mkdir $@

.PHONY:help
.PHONY:clean

clean:
	rm -r wave.vcd $(BUILD_DIR)
plot:
	gtkwave wave.vcd
