.section .data

.section .text

.globl fib
fib:
  sltiu $t0, $a0, 2     # if (n < 2)
  bne $t0, $0, kraj

  addiu $sp, $sp, -12   # rezervisemo mjesto na stack-u

  sw $ra, 8($sp)        # spremamo povratnu adresu na stack
  sw $a0, 4($sp)        # spremamo n
  addiu $a0, $a0, -1    # n-1

  jal fib # foo         # pozivamo fib (foo)

  sw $v0, 0($sp)        # spremamo rezultat od foo(n-1)

  lw $a0, 4($sp)        # ucitajemo n u $a0
  addiu $a0, $a0, -2    # n-2

  jal fib # bar         # pozivamo fib (bar)

  lw $t1, 0($sp)        # ucitajemo rezultat od foo(n-1) u $t1

  addu $v0, $v0, $t1    # $v0 = fib(n-2) + fib(n-1)
  lw $ra, 8($sp)        # ucitavanje povratne adrese u $ra
  addiu $sp, $sp, 12    # dealociranje prostora na stack-u
  jr $ra                

  kraj:
  addiu $v0, $0, 1      # return 1
  jr $ra

.globl main
main:
  
  addiu $v0, $0, 0
  jr $ra
  nop
