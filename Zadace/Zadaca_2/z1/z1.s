.section .rodata

print_str: .asciiz "foo(%d, %d) = %hd\n"

.section .text

.globl foo
foo:
  slti $t0, $a0, 2
  beq $t0, $0, else_if
  addiu $v0, $0, 0
  jr $ra

  else_if:
  slti $t0, $a1, 3
  beq $t0, $0, if_2
  addiu $v0, $0, 1
  jr $ra

  if_2:
  slt $t0, $a0, $a1

  addiu $sp, $sp, -32
  sw $ra, 28($sp)
  sh $a0, 26($sp)
  
  beq $t0, $0, else

  addiu $a0, $a0, -1
  addiu $a1, $a1, -3

  jal foo

  lh $a0, 26($sp)
  addu $v0, $v0, $a0
  
  j return

  else:
  sh $a1, 24($sp)

  addiu $a0, $a0, -2
  addiu $a1, $a1, -1

  jal foo

  lh $a0, 26($sp)
  lh $a1, 24($sp)

  sub $a0, $a0, $a1
  addu $v0, $a0, $v0

  return:
  lw $ra, 28($sp)
  addiu $sp, $sp, 32
  
  jr $ra

.global main
main:
  addiu $sp, $sp, -32
  sw $ra, 28($sp)

  # $t0 -> i
  # $t1 -> j
  
  addiu $t0, $0, 2
  for_i:
  slti $t2, $t0, 6
  beq $t2, $0, break_for_i

  addiu $t1, $0, 3
  for_j:
  slti $t2, $t1, 7
  beq $t2, $0, break_for_j

  sw $t0, 24($sp)
  sw $t1, 20($sp)

  lw $a0, 24($sp)
  lw $a1, 20($sp)

BR:
  jal foo

  la $a0, print_str
  lw $a1, 24($sp)
  lw $a2, 20($sp)
  addiu $a3, $v0, 0

  jal printf
  
  lw $t1, 20($sp)
  lw $t0, 24($sp)

  addiu $t1, $t1, 1
  j for_j
  break_for_j:

  addiu $t0, $t0, 1
  j for_i
  break_for_i:

  lw $ra, 28($sp)
  addiu $sp, $sp, 32

  addiu $v0, $0, 0
  jr $ra
  nop
