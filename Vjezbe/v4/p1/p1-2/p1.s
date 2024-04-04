.section .rodata

.globl niz
niz: .hword 12, 3, -9, 1200, -2400, 490, 800, -23, 5, 22


.section .bss

.globl suma
suma: .word 0

.globl najmanji
najmanji: .hword 0


.section .text

.globl main
main:
  # $t0 -> i
  # $t1 -> najmanji
  # $t2 -> suma
  # $t3 -> niz
  # $t4 -> rezultat poredjenja
  # $t5 -> niz[i]

  la $t3, niz             # pointer na niz

  lh $t1, ($t3)           # $t1 = niz[0]

  addiu $t0, $0, 0        # i = 0
  addiu $t2, $0, 0        # $t2(suma) = 0

L1: # loop 1 (for)
  sltiu $t4, $t0, 10      # $t4 = i < 10
  beq $t4, $0, L1_OUT     # if ($t4 == 0) goto L1_OUT
  
  # OVAJ DIO JE DRUGACIJI U ODNOSU NA p1-1
  sll $t6, $t0, 1         # $t6 = i * 2
  addu $t6, $t3, $t6      # $t6 = niz + i*2 (odnosno $t6 = &niz[i])
  lh $t5, ($t6)           # $t5 = niz[i]

  addu $t2, $t2, $t5      # suma += niz[i]

  # if (niz[i] < najmanji)
  slt $t4, $t5, $t1       # $t4 = niz[i] < najmanji
  beq $t4, $0, OUT_OF_IF  # if ($t4 == 0) goto OUT_OF_IF

  addu $t1, $0, $t5       # najmanji = niz[i]

OUT_OF_IF:
  addiu $t0, $t0, 1       # ++i

  j L1

L1_OUT:
  # pohrana suma i najmanji u memoriju
  # $t5 se od sada koristi za adrese od suma i najmanji
  la $t5, suma            # $t5 = &suma
  sw $t2, ($t5)           # suma = $t2

  la $t5, najmanji        # $t5 = &najmanji
  sh $t1, ($t5)           # najmanji = $t1
  
  # return 0
  addiu $v0, $0, 0
  jr $ra
  nop
