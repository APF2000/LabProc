@ Exercicio 3.10.2 do livro
@ Para debugar este codigo:
@ gcc mult.s && gdb a.out 
	.text
	.globl	main
main:
	LDR r0, =0xffffffff 
	LDR r1, =0x80000000
	BL	firstfunc
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
firstfunc:
	MULS	r2, r0, r1	@ break nesta linha
	MOV	pc, lr
