addiu $4, $0, 0x4444
addiu $5, $0, 0x5555
addu $6, $5, $4
subu $7, $5, $4
addiu $8, $0, 0x8888
addiu $9, $0, 0x9999
sw $4, 0($0)
lw $3, 0($0)
subu $8, $3, $7
addu $7, $5, $6
addiu $10, $0, 0xaaaa
beq $0, $0, BRANCH
addiu $1, $1, 0x1111
addiu $1, $1, 0xffff
BRANCH:
addiu $2, $0, 0x2222
