# FPGA_CLK 时钟引脚
set_property PACKAGE_PIN W19 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
# RESET 复位引脚
set_property PACKAGE_PIN Y19 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
#输出按键引脚约束
set_property PACKAGE_PIN W17 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]
#输出按键引脚约束
set_property PACKAGE_PIN V17 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]
