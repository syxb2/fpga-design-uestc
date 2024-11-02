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
# V sources
V_SOURCES =  \
./test/water_led_tb.v \

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
	@echo ---------------------------------------
	@echo build finished...
	@echo "use <make plot> for plot the waveform"
	@echo "use <make clean> for clean"
	@echo "use <make> for build again"
	@make plot
# $^ 本条规则是所有所需文件的名称，即冒号右边的内容
# $< 是本条规则第一个所需文件的名称，即冒号右边的第一项

$(BUILD_DIR)/$(TARGET).out:$(V_SOURCES) | $(BUILD_DIR)
	@$(CC) -o $@ $(V_SOURCES) 
# $@ 是本条规则被生成的目标名称，即 59 行冒号左边的内容

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
