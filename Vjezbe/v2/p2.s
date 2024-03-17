.section .text
.globl main
main:
  lui $t0, 0xFFFF
  ori $t0, $t0, 0xFFFF
  addiu $v0, $0, 0
  jr $ra
