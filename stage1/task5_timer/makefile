# target
TARGET = vout

# Wave out
WAVE_TARGET = wave.vcd

# Build path
BUILD_DIR = ./build

# V sources:
# make timer
V_SOURCES = \
./test/timer_tb.v
# make led_encoder
# V_SOURCES = \
# ./test/led_encoder_tb.v

# V includes
# make timer
V_INCLUDES = \
./mod/timer.v
# make led_encoder
# V_INCLUDES = \
# ./mod/led_encoder.v

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
