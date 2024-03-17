.section .data
.globl FOO
FOO:
  .word 5

.section .text
.globl bar
bar:
  // neke instrukcije za uvod u funkciju
  la $t1, FOO       // u $t1 je sada pointer na FOO
  lw $t0, 0($t1)    // ucitaj vrijednost FOO u $t0
  addiu $t0, $t0, 4 // dodaj 4 na $t0 i smjesti rezultat u $t0
  sw $t0, 0($t1)    // vrati vrijednost iz $t0 u FOO
