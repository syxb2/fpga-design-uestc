# target
TARGET = vout

# Wave out
WAVE_TARGET = wave.vcd

# Build path
BUILD_DIR = ./build

# V sources:
# make rx
# V_SOURCES = \
./test/rx_tb.v
# make tx
V_SOURCES = \
./test/tx_tb.v

# V includes
# make rx
# V_INCLUDES = \
./mod/rx.v
# make tx
V_INCLUDES = \
./mod/tx.v

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
deploy:
	git add .
	git commit
	git push
