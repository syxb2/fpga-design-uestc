/**
 * CPU 控制单元
 * 
 * 输入：操作码 4 bits
 * 输出：
    * m2reg: 选择 WB 的来源
        * 0 - 选择 alu 作为写回寄存器的来源
        * 1 - 选择 mem 作为写回寄存器的来源
    * pcsrc: 选择 PC 下一条地址的产生方式
        * 0 - 选择 pc + 2 作为下一条指令地址
        * 1 - 选择 pc + imm_sext 作为下一条指令地址
        * 2 - 选择 pc + reg 作为下一条指令地址
    * wmem: 写内存
        * 0 - 不写内存
        * 1 - 写内存
    * aluctrl: ALU 控制：直传、加、减、按位与、按位或、等于、小于等于，共 7 种
        * 0 - ALU 控制：直传
        * 1 - ALU 控制：加
        * 2 - ALU 控制：减
        * 3 - ALU 控制：按位与
        * 4 - ALU 控制：按位或
        * 5 - ALU 控制：等于
        * 6 - ALU 控制：小于等于
    * alusrc: 选择运算操作数
        * 0 - 选择寄存器作为 ALU 的第二个操作数
        * 1 - 选择扩展的立即数作为 ALU 的第二个操作数
    * wreg: 写寄存器
        * 0 - 不写寄存器
        * 1 - 写寄存器
    * jal: 选择写回数据来源
        * 0 - 来源 PC + 2
        * 1 - 来自 WB
 * 
 */
module control_unit (zero, opcode, m2reg, pcsrc, wmem, aluctrl, alusrc, wreg, jal);
    input wire zero; // 结果是否为 0
    input wire [3:0] opcode; // 操作码
    output reg m2reg; // 选择写回寄存器的来源
    output reg [1:0] pcsrc; // 选择 PC 下一条地址的产生方式
    output reg wmem; // 写内存
    output reg [2:0] aluctrl; // ALU 控制：加、减、按位与、按位或、等于、小于等于，共 6 种
    output reg alusrc; // 选择运算操作数
    output reg wreg; // 写寄存器
    output reg jal; // 选择写回数据来源

    parameter NULL = 0;

    always @(*) begin
        case (opcode)
            // 1. jal
            4'b0000: begin
                m2reg = 0; // 0 - 选择 alu 作为 WB 的来源
                pcsrc = 1; // 1 - 选择 pc + imm_sext 作为下一条指令地址
                wmem = 0; // 0 - 不写内存
                aluctrl = NULL; // NULL
                alusrc = NULL; // NULL
                wreg = 1; // 1 - 写寄存器（rd）
                jal = 0; // 0 - 写回数据来自 PC + 2
            end

            // 2. jalr
            4'b0001: begin
                m2reg = 0; // 0 - 选择 alu 作为 WB 的来源
                pcsrc = 2; // 2 - 选择 pc + reg 作为下一条指令地址
                wmem = 0; // 0 - 不写内存
                aluctrl = NULL; // 1 - ALU 控制：加
                alusrc = NULL; // 0 - 选择寄存器作为 ALU 的第二个操作数
                wreg = 1; // 1 - 写寄存器（rd）
                jal = 0; // 0 - 写回数据来自 PC + 2
            end

            // 3. beq
            4'b0010: begin
                // 如果结果为 1，即相等
                if (zero) begin
                    m2reg = 1; // 1 - 选择内存作为 WB 的来源
                    pcsrc = 1; // 1 - 选择 pc + imm_sext 作为下一条指令地址
                    wmem = 0; // 0 - 不写内存
                    aluctrl = 5; // 5 - ALU 控制：等于
                    alusrc = 0; // 0 - 选择寄存器作为 ALU 的第二个操作数
                    wreg = 0; // 0 - 不写寄存器
                    jal = NULL; // NULL
                end
                else begin
                    m2reg = NULL; // NULL
                    pcsrc = 0; // 0 - 选择 pc + 2 作为下一条指令地址
                    wmem = 0; // 0 - 不写内存
                    aluctrl = NULL; // NULL
                    alusrc = NULL; // NULL
                    wreg = 0; // 0 - 不写寄存器
                    jal = NULL; // NULL
                end
            end

            // 4. ble
            4'b0011: begin
                // 如果结果为 1，即小于等于
                if (zero) begin
                    m2reg = 1; // 1 - 选择内存作为写回寄存器的来源
                    pcsrc = 1; // 1 - 选择 pc + imm_sext 作为下一条指令地址
                    wmem = 0;
                    aluctrl = 6; // 6 - ALU 控制：小于等于
                    alusrc = 0; // 0 - 选择寄存器作为 ALU 的第二个操作数
                    wreg = 0; // 0 - 不写寄存器
                    jal = NULL; // NULL
                end
                else begin
                    m2reg = NULL; // NULL
                    pcsrc = 0; // 0 - 选择 pc + 2 作为下一条指令地址
                    wmem = 0; // 0 - 不写内存
                    aluctrl = NULL; // NULL
                    alusrc = NULL; // NULL
                    wreg = 0; // 0 - 不写寄存器
                    jal = NULL; // NULL
                end
            end

            // 5. lb
            4'b0100: begin
                m2reg = 1; // 1 - 选择内存作为 WB 的来源
                pcsrc = 0; // 0 - 选择 pc + 2 作为下一条指令地址
                wmem = 0; // 0 - 不写内存
                aluctrl = 1; // 1 - ALU 控制：加
                alusrc = 1; // 1 - 选择 imm 作为 ALU 的第二个操作数
                wreg = 1; // 1 - 写寄存器（rd）
                jal = 1; // 1 - 写回数据来自 WB
            end

            // 6. lw
            4'b0101: begin
                m2reg = 1; // 1 - 选择内存作为 WB 的来源
                pcsrc = 0; // 0 - 选择 pc + 2 作为下一条指令地址
                wmem = 0; // 0 - 不写内存
                aluctrl = 1; // 1 - ALU 控制：加
                alusrc = 1; // 1 - 选择 imm 作为 ALU 的第二个操作数
                wreg = 1; // 1 - 写寄存器（rd）
                jal = 1; // 1 - 写回数据来自 WB
            end

            // 7. sb
            4'b0110: begin
                m2reg = NULL; // NULL
                pcsrc = 0; // 0 - 选择 pc + 2 作为下一条指令地址
                wmem = 1; // 1 - 写内存
                aluctrl = 0; // 0 - ALU 控制：直传
                alusrc = 0; // 0 - 选择寄存器作为 ALU 的第二个操作数
                wreg = 0; // 0 - 不写寄存器
                jal = NULL; // NULL
            end

            // sw
            4'b0111: begin
                m2reg = NULL; // NULL
                pcsrc = 0; // 0 - 选择 pc + 2 作为下一条指令地址
                wmem = 1; // 1 - 写内存
                aluctrl = 0; // 0 - ALU 控制：直传
                alusrc = 0; // 0 - 选择寄存器作为 ALU 的第二个操作数
                wreg = 0; // 0 - 不写寄存器
                jal = NULL; // NULL
            end

            // add
            4'b1000: begin
                m2reg = 0; // 0 - 选择 alu 作为 WB 的来源
                pcsrc = 0; // 0 - 选择 pc + 2 作为下一条指令地址
                wmem = 0; // 0 - 不写内存
                aluctrl = 1; // 1 - ALU 控制：加
                alusrc = 0; // 0 - 选择寄存器作为 ALU 的第二个操作数
                wreg = 1; // 1 - 写寄存器（rd）
                jal = 1; // 1 - 写回数据来自 WB
            end

            // sub
            4'b1001: begin
                m2reg = 0;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 2; // 2 - ALU 控制：减
                alusrc = 0;
                wreg = 1;
                jal = 1;
            end

            // and
            4'b1010: begin
                m2reg = 0;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 3; // 3 - ALU 控制：按位与
                alusrc = 0;
                wreg = 1;
                jal = 1;
            end

            // or
            4'b1011: begin
                m2reg = 0;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 4; // 4 - ALU 控制：按位或
                alusrc = 0;
                wreg = 1;
                jal = 1;
            end

            // addi
            4'b1100: begin
                m2reg = 0;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 1;
                alusrc = 1; // 1 - 选择扩展的立即数作为 ALU 的第二个操作数
                wreg = 1;
                jal = 1;
            end

            // subi
            4'b1101: begin
                m2reg = 0;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 2;
                alusrc = 1; // 1 - 选择扩展的立即数作为 ALU 的第二个操作数
                wreg = 1;
                jal = 1;
            end

            // addi
            4'b1110: begin
                m2reg = 0;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 3; // 3 - ALU 控制：按位与
                alusrc = 1; // 1 - 选择扩展的立即数作为 ALU 的第二个操作数
                wreg = 1;
                jal = 1;
            end

            // ori
            4'b1111: begin
                m2reg = 0;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 4; // 4 - ALU 控制：按位或
                alusrc = 1;
                wreg = 1;
                jal = 1;
            end
        endcase
    end
endmodule
