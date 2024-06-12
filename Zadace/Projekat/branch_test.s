addiu $t0, $0, 0
addiu $t1, $0, 5
addiu $t2, $0, 5

beq $t0, $0, BRANCH_1
addiu $1, $0, 0xEEEE
j BRANCH_1_OUT
BRANCH_1:
addiu $1, $0, 0x1111
BRANCH_1_OUT:

bne $t0, $0, BRANCH_2
addiu $1, $0, 0x2222
j BRANCH_2_OUT
BRANCH_2:
addiu $1, $0, 0xEEEE
BRANCH_2_OUT:

beq $t1, $t2, BRANCH_3
addiu $1, $0, 0xEEEE
j BRANCH_3_OUT
BRANCH_3:
addiu $1, $0, 0x3333
BRANCH_3_OUT:

bne $t1, $t2, BRANCH_4
addiu $1, $0, 0x4444
j BRANCH_4_OUT
BRANCH_4:
addiu $1, $0, 0xEEEE
BRANCH_4_OUT:

beq $t0, $t1, BRANCH_5
addiu $1, $0, 0x5555
j BRANCH_5_OUT
BRANCH_5:
addiu $1, $0, 0xEEEE
BRANCH_5_OUT:

bne $t0, $t1, BRANCH_6
addiu $1, $0, 0xEEEE
j BRANCH_6_OUT
BRANCH_6:
addiu $1, $0, 0x6666
BRANCH_6_OUT:
nop
