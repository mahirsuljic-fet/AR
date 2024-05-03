.section .rodata

print_str_1: .asciiz "%c"
print_str_2: .asciiz "\n"

.section .bss

.globl d
d: .space 4

.section .text

.globl combinations
combinations:
  addiu $sp, $sp, -32
  sw $ra, 28($sp)

  sw $a0, 24($sp)
  sw $a1, 20($sp)
  sw $a2, 16($sp)

  lw $a0, 16($sp)

  jal malloc

  la $t0, d
  sw $v0, ($t0)
  
  lw $a0, 24($sp)
  lw $a1, 16($sp)
  lw $a2, 20($sp)  
  lw $a3, 16($sp)  

  jal combinations_impl
  
  lw $ra, 28($sp)
  addiu $sp, $sp, 32

  jr $ra

combinations_impl:
  bne $a3, $0, ci_if_out
  addu $a0, $0, $a1

  addiu $sp, $sp, -24
  sw $ra, 20($sp)

  jal print_comb

  lw $ra, 20($sp)
  addiu $sp, $sp, 24

  jr $ra

  ci_if_out:
  # $t0 -> i
  addiu $t0, $0, 0
  addiu $sp, $sp, -48
  sw $ra, 44($sp)
  
  ci_for:
  sltu $t1, $t0, $a2
  beq $t1, $0, ci_for_break

  sw $a3, 40($sp)
  sw $a2, 36($sp)
  sw $a1, 32($sp)
  sw $a0, 28($sp)
  sw $t0, 24($sp)

  subu $t1, $a1, $a3  # maxr - r
  la $t2, d
  addu $t1, $t1, $t2  # $t1 -> &d[maxr - r]

  addu $t2, $a0, $t0
  lbu $t2, ($t2)      # $t2 -> chars[i]

  sb $t2, ($t1)

  addiu $a3, $a3, -1

  jal combinations_impl
  
  lw $a3, 40($sp)
  lw $a2, 36($sp)
  lw $a1, 32($sp)
  lw $a0, 28($sp)
  lw $t0, 24($sp)

  addiu $t0, $t0, 1

  j ci_for
  ci_for_break:
  lw $ra, 44($sp)
  addiu $sp, $sp, 48
  jr $ra

print_comb:
  addiu $sp, $sp, -32
  sw $ra, 28($sp)
  sw $a0, 24($sp)

  # $t0 -> i
  addiu $t0, $0, 0
  pc_for:
  sltu $t1, $t0, $a0
  beq $t1, $0, pc_for_break

  la $a0, print_str_1
  la $a1, d
  addu $a1, $a1, $t0
  lb $a1, ($a1)

  sw $t0, 20($sp)

  jal printf

  lw $t0, 20($sp)
  lw $a0, 24($sp)
  addiu $t0, $t0, 1
  j pc_for
  
  pc_for_break:
  la $a0, print_str_2
  jal printf
  
  lw $ra, 28($sp)
  addiu $sp, $sp, 32
  
  jr $ra

.global main
main:
  addiu $sp, $sp, -24
  sw $ra, 20($sp)

  addiu $t0, $0, 'b'
  sb $t0, 18($sp)
  addiu $t0, $0, 'a'
  sb $t0, 17($sp)

  addiu $a0, $sp, 17
  addiu $a1, $0, 2
  addiu $a2, $0, 2

  jal combinations
  
  lw $ra, 20($sp)
  addiu $sp, $sp, 24
  
  addiu $v0, $0, 0
  jr $ra
  nop
