.section .data

.globl a 
a: .byte 5
.globl b 
b: .byte 7

.section .bss

.globl c 
c: .byte

.section .text

.globl main
main:
  la $t1, a
  lbu $t1, ($t1)

  la $t2, b
  lbu $t2, ($t2)

  beq $t1, $t2, IF
  addiu $t0, $0, $t2
  j ELSE
  IF:
  addiu $t0, $0, $t1
  ELSE:

  addu $t1, $t1, $t2
  sll $t1, $t1, 1

  addiu $v0, $0, 0
  jr $ra
