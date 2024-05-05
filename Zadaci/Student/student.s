.section .rodata

print_str1: .asciiz "ID: %d\n"
print_str2: .asciiz "Name: %s\n"
print_str3: .asciiz "GPA: %.2f\n"
print_str4: .asciiz "Age: %d\n"

.section .text

.globl printStudent
printStudent:
  addiu $sp, $sp, -48
  sw $ra, 44($sp)
  sw $fp, 40($sp)

  addiu $fp, $sp, 48

  sw $a0, 0($fp)
  sw $a1, 4($fp)
  sw $a2, 8($fp)
  sw $a3, 12($fp)
  
  la $a0, print_str1
  lw $a1, 0($fp)
  jal printf

  la $a0, print_str2
  addiu $a1, $fp, 4
  jal printf

  la $a0, print_str3
  lwc1 $f4, 56($fp)
  cvt.d.s $f4, $f4
  mfc1 $a2, $f4
  mfc1 $a3, $f5
  jal printf

  la $a0, print_str4
  lw $a1, 60($fp)
  jal printf
  
  lw $fp, 40($sp)
  lw $ra, 44($sp)
  addiu $sp, $sp, 48
  jr $ra
