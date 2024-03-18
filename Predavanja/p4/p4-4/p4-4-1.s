.section .text

.globl bar
bar:
  and $v0, $a0, $a1
  jr $ra

.globl foo
foo:
  addi $sp, $sp, -8  
  sw $ra, 4($sp)      
  sw $a1, 0($sp)
  addu $a1, $0, $a0
  jal bar
  lw $a1, 0($sp)
  lw $ra, 4($sp)
  addiu $sp, $sp, 8
  addu $v0, $v0, $s0
  jr $s1
