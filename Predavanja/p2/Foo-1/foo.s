	.file	"foo.c"
	.text
	.globl	bar
	.data
	.align 4
	.type	bar, @object
	.size	bar, 4
bar:
	.long	5
	.globl	foo
	.type	foo, @object
	.size	foo, 1
foo:
	.byte	97
	.ident	"GCC: (Ubuntu 13.2.0-4ubuntu3) 13.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
