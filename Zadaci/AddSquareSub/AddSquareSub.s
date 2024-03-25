.section .bss

.globl rez
rez: .word              # int rez;

.section .text

.globl square
square:
  multu $a0, $a0        # $a0 * $a0, odnosno x*x
  mflo $v0              # smijestanje najniza 32 bita rezultata x*x u $v0
  jr $ra                # return

.globl foo
foo:
  addiu $sp, $sp, -12   # rezervisanje memorije na stack-u
  sw $ra, 8($sp)        # spremanje povratne adrese iz $ra na stack
  sw $a0, 4($sp)        # spremanje prvog argumenta ($a0 - a) na stack
  sw $a2, 0($sp)        # spremanje treceg argumenta ($a2 - c) na stack

  addu $a0, $0, $a1     # ucitavanje argumenta za square
  
  jal square            # poziv square

  lw $a0, 4($sp)        # vracanje prvog argumenata (a) sa stack-a u $a0
  lw $a2, 0($sp)        # vracanje treceg argumenata (c) sa stack-a u $a2

  addu $v0, $a0, $v0    # a + square(b)
  subu $v0, $v0, $a2    # (a + square(b)) - c

  lw $ra, 8($sp)        # vracanje povratne adrese u $ra
  addiu $sp, $sp, 12    # dealociranje prostora na stack-u
  jr $ra                # return

.globl main
main:
  # ucitavanje argumenata za foo
  addiu $a0, $0, 1      # a = 1
  addiu $a1, $0, 2      # b = 2
  addiu $a2, $0, 3      # c = 3
  
  addiu $sp, $sp, -4    # rezervisanje prostora na stack-u 
  sw $ra, ($sp)         # spremanje povratne adrese iz $ra na stack

  jal foo               # poziv foo

  lw $ra, ($sp)         # vracanje povratne adresa sa stack-a u $ra
  addiu $sp, $sp, 4     # dealociranje prostora na stack-u

  la $t0, rez           # ucitavanje adrese varijable rez u $t0
  sw $v0, ($t0)         # spremanje rezultata u rez

  addiu $v0, $0, 0      # return 0
  jr $ra
  nop
