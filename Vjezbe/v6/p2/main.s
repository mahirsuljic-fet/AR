# DZ

.section .rodata

print_str: .asciiz "%f\n"

.section .text

.global main
main:
  addiu $sp, $sp, -32
  sw $ra, 28($sp)

  lui $t1, 0x4024
  ori $t1, $t1, 0x4CCC
  lui $t0, 0xCCCC
  ori $t0, $t0, 0xCCCD

  sw $t0, 20($sp)
  sw $t1, 24($sp)

  addiu $a0, $sp, 20

  lui $a3, 0x402E
  ori $a3, $a3, 0x3333
  lui $a2, 0x3333
  ori $a2, $a2, 0x3333

  jal foo
  
  la $a0, print_str
  lw $a2, 20($sp)
  lw $a3, 24($sp)

  jal printf

  lw $ra, 28($sp)
  addiu $sp, $sp, 32

  addiu $v0, $0, 0
  jr $ra
  nop
