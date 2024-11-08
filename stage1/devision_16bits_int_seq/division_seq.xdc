# XDC文件约束

# 设置时钟引脚的约束
# FPGA_CLK 时钟引脚
set_property PACKAGE_PIN W19 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# 设置复位引脚的约束
# RESET 复位引脚
set_property PACKAGE_PIN Y19 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# 设置 start 引脚的约束
# 将 <START_PIN> 替换为 P14
set_property PACKAGE_PIN P14 [get_ports start]
set_property IOSTANDARD LVCMOS33 [get_ports start]

# 设置 done 引脚的约束
# 将 <DONE_PIN> 替换为 P16
set_property PACKAGE_PIN P16 [get_ports done]
set_property IOSTANDARD LVCMOS33 [get_ports done]

# 设置数码管引脚的约束
set_property PACKAGE_PIN K18 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]
set_property PACKAGE_PIN U22 [get_ports out1[0]]
set_property PACKAGE_PIN P19 [get_ports out1[1]]
set_property PACKAGE_PIN W21 [get_ports out1[2]]
set_property PACKAGE_PIN V22 [get_ports out1[3]]
set_property PACKAGE_PIN AB20 [get_ports out1[4]]
set_property PACKAGE_PIN W22 [get_ports out1[5]]
set_property PACKAGE_PIN AA20 [get_ports out1[6]]

set_property PACKAGE_PIN K16 [get_ports led2]
set_property IOSTANDARD LVCMOS33 [get_ports led2]

set_property PACKAGE_PIN L16 [get_ports led3]
set_property IOSTANDARD LVCMOS33 [get_ports led3]

set_property PACKAGE_PIN G20 [get_ports led4]
set_property IOSTANDARD LVCMOS33 [get_ports led4]