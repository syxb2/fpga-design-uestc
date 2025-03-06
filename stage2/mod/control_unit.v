/**
 * CPU 控制单元
 * 
 * 
 */
module control_unit (zero, opcode, m2reg, pcsrc, wmem, aluctrl, alusrc, wreg, jal);
    input wire zero; // 结果是否为 0
    input wire [3:0] opcode; // 操作码
    output reg m2reg; // 选择写回寄存器的来源
    output reg [1:0] pcsrc; // 选择 pc 下一条地址的产生方式
    output reg wmem; // 写内存
    output reg [2:0] aluctrl; // ALU 控制：加、减、与、或、比较
    output reg alusrc; // 选择运算操作数
    output reg wreg; // 写寄存器
    output reg jal; // 选择写回数据来源

    always @(*) begin
        case (opcode)
            // jal
            4'b0000: begin
                m2reg = 0; // 0 - 选择 alu 作为写回寄存器的来源
                pcsrc = 1; // 1 - 选择 pc + imm_sext 作为下一条指令地址
                wmem = 0; // 0 - 不写内存
                aluctrl = 0; // 1 - ALU 控制：加
                alusrc = 1; // 1 - 选择扩展的立即数作为 ALU 的第二个操作数
                wreg = 1; // 1 - 写寄存器
                jal = 0; // 1 - 写回数据来自 alu 计算结果
            end

            // jalr
            4'b0001: begin
                m2reg = 0; // 0 - 选择 alu 作为写回寄存器的来源
                pcsrc = 2; // 2 - 选择 pc + reg 作为下一条指令地址
                wmem = 0; // 0 - 不写内存
                aluctrl = 1; // 1 - ALU 控制：加
                alusrc = 0; // 0 - 选择寄存器作为 ALU 的第二个操作数
                wreg = 1; // 1 - 写寄存器
                jal = 1; // 1 - 写回数据来自 alu 计算结果
            end

            // beq
            4'b0010: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 1;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // ble
            4'b0011: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 2;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // lb
            4'b0100: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 3;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // lw
            4'b0101: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 4;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // sb
            4'b0110: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 5;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // sw
            4'b0111: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 6;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // add
            4'b1000: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 7;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // sub
            4'b1001: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 8;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // and
            4'b1010: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 9;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // or
            4'b1011: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 10;
                alusrc = 0;
                wreg = 1;
                jal = 0;
            end

            // addi
            4'b1100: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 7;
                alusrc = 1;
                wreg = 1;
                jal = 0;
            end

            // subi
            4'b1101: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 9;
                alusrc = 1;
                wreg = 1;
                jal = 0;
            end

            // addi
            4'b1110: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 7;
                alusrc = 1;
                wreg = 1;
                jal = 0;
            end

            // ori
            4'b1111: begin
                m2reg = 1;
                pcsrc = 0;
                wmem = 0;
                aluctrl = 10;
                alusrc = 1;
                wreg = 1;
                jal = 0;
            end
        endcase
    end
    
endmodule