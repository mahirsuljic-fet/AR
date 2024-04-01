# sa int a
main:
  li $t0, 5
  li $t1, 3
  div $t0, $t1
  mfhi $s0

  addiu $sp, $sp, -4
  sw $s0, 0($sp)
  addiu $sp, $sp, 4

# sa constexpr int c
main:
  li $t0, 2

  addiu $sp, $sp, -4
  sw $s0, 0($sp)
  addiu $sp, $sp, 4
