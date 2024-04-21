.section .text

part_impl:
  bne $a0, $a1, REC1
  jr $ra

REC1:
  addiu $sp, $sp, -64
  
  sw $ra, 60($sp)
  sw $a0, 56($sp)
  sw $a1, 52($sp)
  sw $a2, 48($sp)

  lw $a0, ($a0)
  jalr $a2

  lw $a0, 56($sp)
  lw $a1, 52($sp)
  lw $a2, 48($sp)

  beq $v0, $0, ELSE
  
  # $t0 -> *first
  # $t1 -> *last
  lw $t0, ($a0)
  lw $t1, ($a1)
  sw $t1, ($a0)
  sw $t0, ($a1)

  addiu $a1, $a1, -4
  j REC2

ELSE:
  addiu $a0, $a0, 4

REC2:
  jal part_impl

  lw $ra, 60($sp)
  addiu $sp, $sp, 64
  jr $ra

.globl partition
partition:
  slti $t0, $a1, 2
  bne $t0, $0, REC3
  jr $ra

REC3:
  addiu $sp, $sp, 32
  sw $ra, 28($sp)

  sll $t0, $a1, 2
  addu $a1, $a1, $t0
  addiu $a1, $a1, -4

  jal part_impl

  lw $ra, 28($sp)
  addiu $sp, $sp, 32
  jr $ra
