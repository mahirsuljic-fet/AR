.section .text

.globl foo
main:
  addiu $a0, $0, 5
  addiu $a1, $0, 3
  jal foo
  addiu $v0, $0, 10
  jr $ra
