# 第四学期（课程第二阶段）

https://blog.csdn.net/qq_51103378/article/details/131383341?spm=1001.2014.3001.5501

https://github.com/liangkangnan/tinyriscv/tree/master   

## Notes

### 指令集

指令   |  编码
------|-------
jal   |  0000
jalr  |  0001
beq   |  0010
ble   |  0011
lb    |  0100
lw    |  0101
sb    |  0110
sw    |  0111
add   |  1000
sub   |  1001
and   |  1010
or    |  1011
addi  |  1100
subi  |  1101
andi  |  1110
ori   |  1111

### 寄存器编码

寄存器 |  编码  |   说明
------|--------|-------
r0    |  0000  |  恒 0 寄存器
r1    |  0001  |  目的（返回地址）寄存器 rd
r2    |  0010  |  栈指针寄存器 sp
r3    |  0011  |  a0 还作为保存函数参数或返回值
r4    |  0100  |  a1
r5    |  0101  |  a2
r6    |  0110  |  a3
r7    |  0111  |  a4
r8    |  1000  |  a5
r9    |  1001  |  a6
r10   |  1010  |  a7
r11   |  1011  |  a8
r12   |  1100  |  a9
r13   |  1101  |  a10
r14   |  1110  |  a11
r15   |  1111  |  a12

### 指令举例

指令操作码顺序：imm_rs1_rs2_rd_opcode

1. jal rd, imm：将 PC 的值加上 2，结果写入 rd 寄存器，同时将 PC 的值设置为 PC 加上符号位拓展的 imm，即 PC = PC + sext(imm)。
    * 0000_0100(imm)_0001(rd)_0000(jal)
    * PC + 2 是因为 jal 指令的下一条指令地址是 PC + 2（指令长度为 16 位，即 2 个字节）。
2. jalr rd, rs1, imm：将 PC 的值加上 2，结果写入 rd 寄存器，同时将 PC 值设置为寄存器 rs1 的值加上符号位拓展的 imm ， 即 PC = rs1 + sext(imm)。
    * 0100(imm)_0011(rs1)_0001(rd)_0001(jalr)
3. beq rs1, rs2, offset：如果 rs1 和 rs2 的值相等，则将 PC 的值设置为 PC 加上符号位拓展的 offset，即 PC = PC + sext(offset)。
    * 0010(offset)_0011(rs1)_0100(rs2)_0010(beq)
4. ble rs1, rs2, offset：如果 rs1 小于等于 rs2，则将 PC 的值设置为 PC 加上符号位拓展的 offset，即 PC = PC + sext(offset)。
    * 0011(offset)_0011(rs1)_0100(rs2)_0011(ble)
5. lb rd, offset(rs1)：将 PC 的值加 2，将内存地址 rs1 + offset 处的 8 位数据读取到 rd 寄存器中。
    * 0100(offset)_0011(rs1)_0001(rd)_0100(lb)
6. lw rd, offset(rs1)：将 PC 的值加 2，将内存地址 rs1 + offset 处的 16 位数据读取到 rd 寄存器中。
    * 0101(offset)_0011(rs1)_0001(rd)_0101(lw)
7. sb rs2, offset(rs1)：将 PC 的值加 2，将 rs2 寄存器的值写入内存地址 rs1 + offset 处。
    * 0110(offset)_0011(rs1)_0100(rs2)_0110(sb)
8. sw rs2, offset(rs1)：将 PC 的值加 2，将 rs2 寄存器的值写入内存地址 rs1 + offset 处。
    * 0111(offset)_0011(rs1)_0100(rs2)_0111(sw)
9. add rd, rs1, rs2：将 PC 的值加 2，将 rs1 和 rs2 寄存器的值相加，结果写入 rd 寄存器。
    * 0011(rs1)_0100(rs2)_0001(rd)_1000(add)
10. sub rd, rs1, rs2：将 PC 的值加 2，将 rs1 寄存器的值减去 rs2 寄存器的值，结果写入 rd 寄存器。
    * 0011(rs1)_0100(rs2)_0001(rd)_1001(sub)
11. and rd, rs1, rs2：将 PC 的值加 2，将 rs1 和 rs2 寄存器的值按位与，结果写入 rd 寄存器。
    * 0011(rs1)_0100(rs2)_0001(rd)_1010(and)
12. or rd, rs1, rs2：将 PC 的值加 2，将 rs1 和 rs2 寄存器的值按位或，结果写入 rd 寄存器。
    * 0011(rs1)_0100(rs2)_0001(rd)_1011(or)
13. addi rd, rs1, imm：将 PC 的值加 2，将 rs1 寄存器的值加上符号位拓展的 imm，结果写入 rd 寄存器。
    * 0000(imm)_0011(rs1)_0001(rd)_1100(addi)
14. subi rd, rs1, imm：将 PC 的值加 2，将 rs1 寄存器的值减去符号位拓展的 imm，结果写入 rd 寄存器。
    * 0000(imm)_0011(rs1)_0001(rd)_1101(subi)
15. andi rd, rs1, imm：将 PC 的值加 2，将 rs1 寄存器的值与符号位拓展的 imm 按位与，结果写入 rd 寄存器。
    * 0000(imm)_0011(rs1)_0001(rd)_1110(andi)
16. ori rd, rs1, imm：将 PC 的值加 2，将 rs1 寄存器的值与符号位拓展的 imm 按位或，结果写入 rd 寄存器。
    * 0000(imm)_0011(rs1)_0001(rd)_1111(ori)



