	.text
	.abicalls
	.option	pic0
	.section	.mdebug.abi32,"",@progbits
	.nan	legacy
	.file	"temp.c"
	.text
	.globl	printStudent
	.p2align	2
	.type	printStudent,@function
	.set	nomicromips
	.set	nomips16
	.ent	printStudent
printStudent:
	.frame	$fp,136,$ra
	.mask 	0xc0030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	.set	noat
	addiu	$sp, $sp, -136
	sw	$ra, 132($sp)
	sw	$fp, 128($sp)
	sw	$17, 124($sp)
	sw	$16, 120($sp)
	move	 $fp, $sp
	lw	$1, 196($fp)
	lw	$2, 192($fp)
	lw	$3, 188($fp)
	lw	$8, 184($fp)
	lw	$9, 180($fp)
	lw	$10, 176($fp)
	lw	$11, 172($fp)
	lw	$12, 168($fp)
	lw	$13, 164($fp)
	lw	$14, 160($fp)
	lw	$15, 156($fp)
	lw	$24, 152($fp)
	move	 $25, $7
	move	 $gp, $6
	move	 $16, $5
	move	 $17, $4
	sw	$4, 56($fp)
	addiu	$4, $fp, 56
	ori	$4, $4, 4
	sw	$5, 60($fp)
	sw	$6, 64($fp)
	sw	$7, 68($fp)
	sw	$24, 72($fp)
	sw	$15, 76($fp)
	sw	$14, 80($fp)
	sw	$13, 84($fp)
	sw	$12, 88($fp)
	sw	$11, 92($fp)
	sw	$10, 96($fp)
	sw	$9, 100($fp)
	sw	$8, 104($fp)
	sw	$3, 108($fp)
	sw	$2, 112($fp)
	sw	$1, 116($fp)
	lw	$5, 56($fp)
	lui	$1, %hi($.str)
	addiu	$1, $1, %lo($.str)
	sw	$4, 52($fp)
	move	 $4, $1
	sw	$gp, 48($fp)
	sw	$16, 44($fp)
	sw	$25, 40($fp)
	sw	$17, 36($fp)
	jal	printf
	nop
	lui	$1, %hi($.str.1)
	addiu	$4, $1, %lo($.str.1)
	lw	$5, 52($fp)
	sw	$2, 32($fp)
	jal	printf
	nop
	lwc1	$f0, 112($fp)
	cvt.d.s	$f2, $f0
	lui	$1, %hi($.str.2)
	addiu	$4, $1, %lo($.str.2)
	mfc1	$6, $f2
	mfhc1	$7, $f2
	sw	$2, 28($fp)
	jal	printf
	nop
	lw	$5, 116($fp)
	lui	$1, %hi($.str.3)
	addiu	$4, $1, %lo($.str.3)
	sw	$2, 24($fp)
	jal	printf
	nop
	sw	$2, 20($fp)
	move	 $sp, $fp
	lw	$16, 120($sp)
	lw	$17, 124($sp)
	lw	$fp, 128($sp)
	lw	$ra, 132($sp)
	addiu	$sp, $sp, 136
	jr	$ra
	nop
	.set	at
	.set	macro
	.set	reorder
	.end	printStudent
$func_end0:
	.size	printStudent, ($func_end0)-printStudent

	.type	$.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
$.str:
	.asciz	"ID: %d\n"
	.size	$.str, 8

	.type	$.str.1,@object
$.str.1:
	.asciz	"Name: %s\n"
	.size	$.str.1, 10

	.type	$.str.2,@object
$.str.2:
	.asciz	"GPA: %.2f\n"
	.size	$.str.2, 11

	.type	$.str.3,@object
$.str.3:
	.asciz	"Age: %d\n"
	.size	$.str.3, 9


	.ident	"ecc version 2017-08-23 (http://ellcc.org) based on clang version 6.0.0 (trunk 311547)"
	.section	".note.GNU-stack","",@progbits
	.text
