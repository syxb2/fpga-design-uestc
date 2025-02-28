class CPU:
    def __init__(self, name, PC=0, IR=0b0000000000000000):
        self.name = name
        self.PC = PC
        self.IR = IR
        self.R1 = 0
        self.R2 = 0
        self.R3 = 0
        self.R4 = 0
        self.R5 = 0

    def decoder(self, IR):
        opcode = IR & 0b1111 # opcode is the last 4 bits of IR
        operand1 = (IR >> 4) & 0b1111 # operand1 is the 4th to 7th bits of IR
        operand2 = (IR >> 8) & 0b1111
        operand3 = (IR >> 12) & 0b1111
        return opcode, operand1, operand2, operand3

