.section .text

.globl roundToTick
roundToTick:
  l.d $f4, 0($a0)
  mtc1 $a1, $f6
  cvt.d.w $f6, $f6
  mul.d $f4, $f4, $f6
  div.d $f4, $f4, $f6
  s.d $f4, 0($a0)
  jr $ra

.globl getTick
getTick:
  mtc1 $0, $f4
  mtc1 $0, $f5
  c.eq.d $f12, $f4
  bc1f gt_if1_out
  mtc1 $0, $f0
  mtc1 $0, $f1
  jr $ra

  gt_if1_out:
  addiu $t0, $0, 1
  mtc1 $t0, $f8
  cvt.d.w $f8, $f8
  
  addiu $t0, $0, 10
  mtc1 $t0, $f4
  cvt.d.w $f4, $f4

  c.lt.d $f12, $f4
  bc1f gt_if2_out

  addiu $t0, $0, 1000
  mtc1 $t0, $f4
  cvt.d.w $f4, $f4
  
  div.d $f0, $f8, $f4
  jr $ra

  gt_if2_out:
  addiu $t0, $0, 100
  mtc1 $t0, $f4
  cvt.d.w $f4, $f4

  c.lt.d $f12, $f4
  bc1f gt_if3_out

  addiu $t0, $0, 100
  mtc1 $t0, $f4
  cvt.d.w $f4, $f4
  
  div.d $f0, $f8, $f4
  jr $ra

  gt_if3_out:
  addiu $t0, $0, 1000
  mtc1 $t0, $f4
  cvt.d.w $f4, $f4

  c.lt.d $f12, $f4
  bc1f gt_if4_out

  addiu $t0, $0, 10
  mtc1 $t0, $f4
  cvt.d.w $f4, $f4
  
  div.d $f0, $f8, $f4
  jr $ra

  gt_if4_out:
  mov.d $f0, $f8
  jr $ra

.globl calculateAmount
calculateAmount:
  addiu $sp, $sp, -32
  sw $ra, 28($sp)

  s.d $f12, 16($sp)
  sw $a2, 24($sp)

  jal getTick

  addiu $t0, $0, 1
  mtc1 $t0, $f4
  cvt.d.w $f4, $f4
  div.d $f4, $f4, $f0
  mfc1 $a2, $f4
  mfc1 $a3, $f5

  addiu $a0, $sp, 16

  jal roundToTick

  l.d $f4, 16($sp)
  lwc1 $f6, 24($sp)
  cvt.d.w $f6, $f6

  mul.d $f0, $f4, $f6
  
  lw $ra, 28($sp)
  addiu $sp, $sp, 32
  jr $ra
