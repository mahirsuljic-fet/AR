.section .text

.globl square
square:
  mult $a0, $a0
  mflo $v0
  jr $ra

.globl foo
foo:
  addi $sp, $sp, -8
  sw $ra, 4($sp)
  sw $a0, 0($sp)
  addu $a0, $0, $a1
  jal square
  lw $a0, 0($sp)
  lw $ra, 4($sp)
  addu $t0, $a0, $v0
  sub $v0, $t0, $a2
  addiu $sp, $sp, 8
  jr $ra

.globl main
main:
  addiu $a0, $0, 1
  addiu $a1, $0, 2
  addiu $a2, $0, 3
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  jal foo
  lw $ra, 0($sp)
  addiu $sp, $sp, 4
  addi $v0, $0, 0
  jr $ra
  nop
