# DZ

.section .rodata

print_str: .asciiz "%f\n"

.section .text

.global main
main:
  addiu $sp, $sp, -32
  sw $ra, 28($sp)

  # double spremamo na taj nacin da druga 4 bajta
  # idu u memoriju prije prva 4 bajta, "naopako"
  # ovo se radi jer koristimo little endian sistem

  lui $t1, 0x4024
  ori $t1, $t1, 0x4CCC
  lui $t0, 0xCCCC
  ori $t0, $t0, 0xCCCD

  sw $t0, 16($sp)
  sw $t1, 20($sp)

  addiu $a0, $sp, 16

  # i ovdje ucitajemo broj "naopako"
  lui $a3, 0x402E
  ori $a3, $a3, 0x3333
  lui $a2, 0x3333
  ori $a2, $a2, 0x3333

  jal foo
  
  la $a0, print_str
  # $a1 je "prazan" (nije bitna vrijednost) 
  # jer je prvi argument pointer a drugi argument double
  lw $a2, 16($sp)
  lw $a3, 20($sp)

  jal printf

  lw $ra, 28($sp)
  addiu $sp, $sp, 32

  addiu $v0, $0, 0
  jr $ra
  nop
