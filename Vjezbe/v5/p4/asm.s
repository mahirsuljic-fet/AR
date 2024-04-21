.section .text

.globl isPalindrome
isPalindrome:
  slti $t0, $a1, 2
  beq $t0, $0, recursion
  addiu $v0, $0, 1
  jr $ra

recursion:
  addiu $sp, $sp, -32

  addu $t1, $a0, $a1
  addiu $t1, $a1, -1
  lb $t1, ($t1)

  beq $t0, $t1, rec2
  addiu $v0, $0, 0
  jr $ra

rec2:
  sw $ra, 28($sp)
  addiu $a0, $a0, 1
  addiu $a1, $a1, -2

  jal isPalindrome

  lw $ra, 28($sp)
  addiu $sp, $sp, 32

  jr $ra
