@ Exercicio 3.10.1 : 1a soma do exercicio
@ Para debugar este codigo:
@ gcc mult.s && gdb a.out 
	.text
	.globl	main
main:
	LDR r0, =0xffff0000 @MOV	r0, #15
	LDR r1, =0x87654321 @MOV	r1, #20
	BL	firstfunc
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
firstfunc:
	ADDS	r2, r0, r1 @ breakpoint aqui
	ADD	r3, r0, r1 @ outro breakpoint aqui (dá step para ir de um pro outro)
	MOV	pc, lr
