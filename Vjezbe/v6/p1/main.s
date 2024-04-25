.section .rodata

print_str: .asciiz "p=%f\n"

.section .text

.global main
main:
  addiu $sp, $sp, -32
  sw $ra, 28($sp)
  
  lui $t0, 0x4123
  ori $t0, $t0, 0x3333
  sw $t0, 24($sp)
  addiu $a0, $sp, 24

  jal foo

  lwc1 $f4, 24($sp)
  cvt.d.s $f4, $f4
  mfc1 $a2, $f4
  mfc1 $a3, $f5
  la $a0, print_str

  jal printf

  lw $ra, 28($sp)
  addiu $sp, $sp, 32
  
  addiu $v0, $0, 0
  jr $ra
  nop
