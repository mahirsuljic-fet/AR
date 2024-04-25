.section .data

a: .word 5
.globl c
c: .float -2.5

.section .text

.globl foo
foo:
  # p4 -> *p
  lwc1 $f4, ($a0)

  la $t0, a
  lwc1 $f6, ($t0)
  cvt.s.w $f6, $f6

  la $t0, a
  lwc1 $f8, ($t0)

  add.s $f6, $f6, $f8
  add.s $f6, $f6, $f4

  swc1 $f6, ($a0)

  jr $ra
  nop
