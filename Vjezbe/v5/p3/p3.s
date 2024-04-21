.section .text

.globl factorial
factorial:
  bne $a0, $0, recursion
  addiu $v0, $0, 1
  jr $ra
recursion:
  addiu $sp, $sp, -32

  sw $ra, 28($sp)
  sw $a0, 24($sp)

  addiu $a0, $a0, -1

  jal factorial

  lw $a0, 24($sp)
  lw $ra, 28($sp)

  mult $a0, $v0
  mflo $v0

  addiu $sp, $sp, 32
  jr $ra
