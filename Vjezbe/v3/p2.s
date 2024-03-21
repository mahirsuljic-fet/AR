.section .data

.section .bss

.section .text

.globl main
main:
  li $t0, 0xF4672B13
  li $t1, 0xAAAAAAAA

  and $t1, $t0, $t1

  addiu $v0, $0, 0
  jr $ra
