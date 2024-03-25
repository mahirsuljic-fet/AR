.section .data

rez: .word 0

.section .text

.globl sum
sum:
  addiu $v0, $0, 0
  addiu $t0, $0, 1

  # inkrementujemo $a0 jer je $t0 <= $a0 isto sto i $t0 < $a0 + 1
  # ovo je pozeljno jer samo postoji instrukcija slt (set less than)
  addiu $a0, $a0, 1

  for:
  slt $t1, $t0, $a0
  beq $t1, $0, break_for
  addu $v0, $v0, $t0
  addiu $t0, $t0, 1
  j for
  nop

  break_for:
  jr $ra
  nop

.globl main
main:
  addiu $a0, $0, 5

  addiu $sp, $sp, -4
  sw $ra, ($sp)
  
  jal sum

  lw $ra, ($sp)
  addiu $sp, $sp, 4

  la $t0, rez
  sw $v0, ($t0)
  
  addiu $v0, $0, 0
  jr $ra
  nop
