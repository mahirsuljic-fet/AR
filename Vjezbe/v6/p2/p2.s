.section .data

a: .word 5

.globl foo
foo:
  # t0 -> a
  la $t0, a
  lw $t0, ($t0)

  mtc1 $t0, $f4
  cvt.d.w $f4, $f4

  mtc1 $a2, $f6
  mtc1 $a3, $f7

  add.d $f4, $f4, $f6
  
  # f6 -> *p
  l.d $f6, ($a0)
  
  add.d $f4, $f4, $f6

  s.d $f4, ($a0)

  jr $ra
