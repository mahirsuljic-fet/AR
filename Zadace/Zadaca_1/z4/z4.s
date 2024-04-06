.section .data

.globl size
size: .hword 6
# size: .hword 5

.globl niz
niz: .hword 1, 19, 350, 740, 1552, 2020
# niz: .hword 1, 19, 350, 740, 1522 

.globl result
result: .word 0


.section .text

.globl main
main:
  # $t0 -> sorted       (da li je niz sortiran)
  # $t1 -> &niz[i]
  # $t2 -> &niz[i-1]
  # $t3 -> &niz[size]   (adresa nakon zadnjeg clana)
  # $t4 -> privremene vrijednosti
  # $t5 -> privremene vrijednosti
  # $t6 -> niz
  # $t7 -> &size
  # $t8 -> &result

  la $t6, niz               # $t6 = niz
  la $t7, size              # $t7 = &size
  la $t8, result            # $t8 = &result

  addiu $t0, $0, 1          # pretpostavimo da je niz sortiran
  addu $t2, $0, $t6         # $t2 = niz
  addiu $t1, $t2, 2         # $t1 = &niz[1] = $t2 + 2   (2 jer je hword)

  lh $t4, ($t7)             # $t4 = size
  sll $t4, $t4, 1           # mnozimo sa 2 jer radimo sa hword
  addu $t3, $t2, $t4        # $t3 = niz + size

while:
  beq $t1, $t3, while_out   # ako smo dosli do kraja niza izadji iz petlje

  lh $t4, ($t1)             # $t4 = niz[i]
  lh $t5, ($t2)             # $t5 = niz[i-1]
  slt $t4, $t4, $t5         # $t4 = niz[i] < niz[i-1]
  beq $t4, $0, increment    # ako je niz[i] < niz[i-1] pomjeri pointere

  addiu $t0, $0, 0          # ako nije niz[i] < niz[i-1] => sorted = 0
  j while_out               # izlaz iz petlje
  
increment:
  # pomjerimo pointer za jedno mjesto, 
  # tako da pokazuju na sljedeci element
  # koristimo 2 jer radimo sa hword
  addiu $t1, $t1, 2         # ++$t1
  addiu $t2, $t2, 2         # ++$t2
  j while                   # izlaz iz petlje

while_out:
  bne $t0, $0, if1_out      # ako je niz sortiran izadji iz if-a

  # ucitavanje 0xDEADFA11 u $t0 i skok na kraj programa
  lui $t0, 0xDEAD
  ori $t0, $t0, 0xFA11
  j end

if1_out:
  lh $t0, ($t7)       # $t0 = size

  andi $t5, $t0, 1    # ekstrakcija zadnjeg bita zbog provjere parnosti size

  # $t4 = size / 2
  div $t0, 2
  mflo $t4

  # $t2 = &niz[size/2]; postavljamo $t2 na adresu srednjeg elementa
  sll $t4, $t4, 1     # mnozimo sa 2 jer radimo sa hword
  addu $t2, $t6, $t4  # $t2 = &niz[size/2]        (niz + size/2)
  
  bne $t5, $0, else   # ako je size neparan idi na else

  addiu $t3, $t2, -2  # $t3 = &niz[size/2 - 1]    (niz + size/2 - 1)

  lh $t2, ($t2)       # $t2 = niz[size/2]
  lh $t3, ($t3)       # $t3 = niz[size/2 - 1]
  addu $t0, $t2, $t3  # $t0 = niz[size/2] + niz[size/2 - 1]

  # $t0 = (niz[size/2] + niz[size/2 - 1]) / 2
  div $t0, 2
  mflo $t0

  j end

else:
  lh $t0, ($t2)       # $t0 = niz[size/2]

end:
  sw $t0, ($t8)       # result = $t0

  # return 0
  addiu $v0, $0, 0
  jr $ra
  nop
