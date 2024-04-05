.section .rodata

.globl number
number: .word 4


.section .data

.globl result 
result: .byte 0


.section .text

.globl main
main:
  # $s0 -> &number (adresa od number)
  # $s1 -> &result (adresa od result)

  la $s0, number          # ucitaj adresu od number u $s0
  la $s1, result          # ucitaj adresu od result u $s1

  # PRVI DIO

  # $t0 -> number
  # $t1 -> result

  # broj je paran ako mu je zadnji bit 0
  # znaci parnost se moze provjeriti tako sto se provjeri zadnji bit
  # rezultat ce biti 1 ako je broj neparan, 0 ako je paran
  # posto zelimo obrnuto, potrebno je zadnji bit rezultata flip-ovati

  lw $t0, ($s0)           # ucitaj number u $t0
  andi $t1, $t0, 0x0001   # izvuci zadnji bit iz $t0 i smjesti rezultat u $t1
  xori $t1, $t1, 0x0001   # flip-aj zadnji bit iz $t1
  sw $t1, ($s1)           # spremi rezultat u result

  addiu $v0, $0, 0
  jr $ra
  nop
