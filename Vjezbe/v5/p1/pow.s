.section .text

.globl power
power:
  # $v0 -> res
  # $t0 -> i
  # $t1 -> *num
  addiu $v0, $0, 1
  addiu $t0, $0, 0
  lw $t1, ($a0)

L1:
  slt $t3, $t0, $a1
  beq $t3, $0, L1_OUT
  mult $v0, $t1
  mflo $v0
  addiu $t0, $t0, 1
  j L1

L1_OUT:  
  jr $ra
  nop
