# XDC文件约束

# 设置时钟引脚的约束
set_property PACKAGE_PIN W19 [get_ports clk] # FPGA_CLK 时钟引脚
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# devision_seq Module Constraints
# 假设 start, done, a, b, y, remainder 已经根据实际引脚映射表分配了引脚

# 设置 start 引脚的约束
set_property PACKAGE_PIN <START_PIN> [get_ports start] # 替换 <START_PIN> 为实际的引脚编号
set_property IOSTANDARD LVCMOS33 [get_ports start]

# 设置 done 引脚的约束
set_property PACKAGE_PIN <DONE_PIN> [get_ports done] # 替换 <DONE_PIN> 为实际的引脚编号
set_property IOSTANDARD LVCMOS33 [get_ports done]

# 例如，对于 out1[]，替换 <A0_PIN> 为实际的引脚编号
set_property PACKAGE_PIN <A0_PIN> [get_ports out1[0]] 
set_property IOSTANDARD LVCMOS33 [get_ports out1[0]] 
set_property PACKAGE_PIN <A0_PIN> [get_ports out1[1]] 
set_property IOSTANDARD LVCMOS33 [get_ports out1[1]] 
set_property PACKAGE_PIN <A0_PIN> [get_ports out1[2]] 
set_property IOSTANDARD LVCMOS33 [get_ports out1[2]] 
set_property PACKAGE_PIN <A0_PIN> [get_ports out1[3]] 
set_property IOSTANDARD LVCMOS33 [get_ports out1[3]] 
set_property PACKAGE_PIN <A0_PIN> [get_ports out1[4]] 
set_property IOSTANDARD LVCMOS33 [get_ports out1[4]] 
set_property PACKAGE_PIN <A0_PIN> [get_ports out1[5]] 
set_property IOSTANDARD LVCMOS33 [get_ports out1[5]] 
set_property PACKAGE_PIN <A0_PIN> [get_ports out1[6]] 
set_property IOSTANDARD LVCMOS33 [get_ports out1[6]] 

# 例如，对于 out2[]，替换 <B0_PIN> 为实际的引脚编号
set_property PACKAGE_PIN <B0_PIN> [get_ports out2[0]]
set_property IOSTANDARD LVCMOS33 [get_ports out2[0]] 
set_property PACKAGE_PIN <B0_PIN> [get_ports out2[1]] 
set_property IOSTANDARD LVCMOS33 [get_ports out2[1]] 
set_property PACKAGE_PIN <B0_PIN> [get_ports out2[2]] 
set_property IOSTANDARD LVCMOS33 [get_ports out2[2]] 
set_property PACKAGE_PIN <B0_PIN> [get_ports out2[3]] 
set_property IOSTANDARD LVCMOS33 [get_ports out2[3]] 
set_property PACKAGE_PIN <B0_PIN> [get_ports out2[4]] 
set_property IOSTANDARD LVCMOS33 [get_ports out2[4]] 
set_property PACKAGE_PIN <B0_PIN> [get_ports out2[5]] 
set_property IOSTANDARD LVCMOS33 [get_ports out2[5]] 
set_property PACKAGE_PIN <B0_PIN> [get_ports out2[6]] 
set_property IOSTANDARD LVCMOS33 [get_ports out2[6]] 

# 例如，对于 out3[]，替换 <Y0_PIN> 为实际的引脚编号
set_property PACKAGE_PIN <Y0_PIN> [get_ports out3[0]] 
set_property IOSTANDARD LVCMOS33 [get_ports out3[0]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out3[1]] 
set_property IOSTANDARD LVCMOS33 [get_ports out3[1]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out3[2]] 
set_property IOSTANDARD LVCMOS33 [get_ports out3[2]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out3[3]] 
set_property IOSTANDARD LVCMOS33 [get_ports out3[3]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out3[4]] 
set_property IOSTANDARD LVCMOS33 [get_ports out3[4]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out3[5]] 
set_property IOSTANDARD LVCMOS33 [get_ports out3[5]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out3[6]] 
set_property IOSTANDARD LVCMOS33 [get_ports out3[6]] 

# 例如，对于 out3[]，替换 <Y0_PIN> 为实际的引脚编号
set_property PACKAGE_PIN <Y0_PIN> [get_ports out4[0]] 
set_property IOSTANDARD LVCMOS33 [get_ports out4[0]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out4[1]] 
set_property IOSTANDARD LVCMOS33 [get_ports out4[1]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out4[2]] 
set_property IOSTANDARD LVCMOS33 [get_ports out4[2]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports ouu4[3]] 
set_property IOSTANDARD LVCMOS33 [get_ports out4[3]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out4[4]] 
set_property IOSTANDARD LVCMOS33 [get_ports out4[4]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out4[5]] 
set_property IOSTANDARD LVCMOS33 [get_ports out4[5]] 
set_property PACKAGE_PIN <Y0_PIN> [get_ports out4[6]] 
set_property IOSTANDARD LVCMOS33 [get_ports out4[6]] 