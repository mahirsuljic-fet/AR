.section .data
.globl num
num: .word 10

.section .text
.globl main
main:
  addiu $t1, $0, 100
  addiu $t2, $0, -20
  addiu $t3, $0, 5
  addu $t0, $t1, $t2
  or $t0, $t0, $t3
  addiu $v0, $0, 0
  jr $ra
