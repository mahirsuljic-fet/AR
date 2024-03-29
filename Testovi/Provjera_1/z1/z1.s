.section .rodata

.globl num
num: .hword 0xC0DE

.section .bss

.globl res
res: .byte

.section .text

.globl main
main:
  # t0 = num
  la $t0, num         # ucitavanje adrese od num u $t0  ($t0 = &num)
  lhu $t0, ($t0)      # ucitavanje num u $t0

  # t1 = t0 + 0xCAFE0000
  lui $t1, 0xCAFE     # $t1 = 0xCAFE0000
  addu $t1, $t0, $t1  # $t1 = $t0 + $t1;  ($t1 = 0xCAFE0000)

  # res = t1
  la $t2, res         # ucitavanje adrese od res u $t2  ($t2 = &res)
  sb $t1, ($t2)       # pohrana vrijednosti $t1 u res

  # return res
  lb $v0, ($t2)       # ucitavanje vrijednosti res u $v0
  jr $ra              # return
  nop
