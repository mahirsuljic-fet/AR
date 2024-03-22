.section .data

.globl a 
a: .byte 25
.globl b 
b: .byte -2
.globl c 
c: .byte -10
.globl d 
d: .hword 40000
.globl e 
e: .hword 40000
.globl x 
x: .word 3400
.globl y 
y: .word 2800

.section .bss

.globl f 
f: .word
.globl g 
g: .hword
.globl h
h: .hword
.globl i 
i: .word
.globl j 
j: .word
.globl z 
z: .word

.section .text

.globl main
main:
  la $t0, f
  la $t0, a
  lbu $t0, ($t0)
  addiu $t1, $t0, 190
  la $t0, f
  sw $t1, ($t0)

  la $t0, b
  lb $t0, ($t0)
  addiu $t1, $t0, -12
  la $t0, g
  sh $t1, ($t0)

  la $t0, c
  lbu $t0, ($t0)
  addiu $t1, $t0, 15
  la $t0, h
  sh $t1, ($t0)

  la $t0, d
  lbu $t0, ($t0)
  li $t1, -45000
  addu $t1, $t0, $t1
  la $t0, i
  sw $t1, ($t0)

  la $t0, e
  lbu $t0, ($t0)
  li $t1, -45000
  addu $t1, $t0, $t1
  la $t0, j
  sw $t1, ($t0)

  la $t0, x
  lb $t1, ($t0)
  la $t0, y
  lb $t2, ($t0)
  addu $t1, $t1, $t2
  la $t0, z
  sw $t1, ($t0)

  addiu $v0, $0, 0
  jr $ra
