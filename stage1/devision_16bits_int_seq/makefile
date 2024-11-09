# ------------------------------------------------
# Generic Makefile (based on iverilog)
# @Author : sudo
# ChangeLog :
#	2023-03-22 - creat this project
#   2023-03-22 - first version
# ------------------------------------------------

######################################
# target
######################################
TARGET = vout

#######################################
# paths
#######################################
# Build path
BUILD_DIR = ./build

######################################
# source
######################################
# V sources:
# Version 1
# V_SOURCES = \
# ./test/devision_seq_tb.v \
# ./src/devision_seq.v \
# ./src/led_encoder.v

# Version 2
# V_SOURCES = \
# ./test/devision_seq_board_tb.v \
# ./src/devision_seq_board.v \
# ./src/led_encoder_board.v

# Version 3
V_SOURCES = \
./test/devision_seq_led_board_tb.v \
./src/devision_seq_led_board.v

# # V includes
# V_INCLUDES =  \
# -Itest/full_adder

#######################################
# binaries
#######################################
PREFIX =
# The iverilog compiler bin path can be either defined in make command via VCC_PATH variable (> make VCC_PATH=xxx)
# either it can be added to the PATH environment variable.

ifdef VCC_PATH
CC = $(VCC)/$(PREFIX)iverilog
VP = $(VCC)/$(PREFIX)vvp
else
CC = $(PREFIX)iverilog
VP = $(PREFIX)vvp
endif

# default action: build all
all:wave.vcd

wave.vcd:$(BUILD_DIR)/$(TARGET).out | $(BUILD_DIR)
	@$(VP) -n $^
	@echo build finished...
	@echo "use <make plot> for plot the waveform"
	@echo "use <make clean> for clean"
	@make plot

$(BUILD_DIR)/$(TARGET).out:$(V_SOURCES) | $(BUILD_DIR)
	@$(CC) -o $@ $(V_SOURCES) 
# $@ 表示 58 行所有内容

$(BUILD_DIR):
	@mkdir $@

.PHONY:help
.PHONY:clean

# windows
# clean:
# 	@del wave.vcd
# 	@rmdir /Q /S $(BUILD_DIR)

# linux & mac
clean:
	rm Rf wave.vcd $(BUILD_DIR)/*.out

plot:
	@gtkwave wave.vcd
