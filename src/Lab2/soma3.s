@ Exercicio 3.10.1 : 3a soma do exercicio
@ Para debugar este codigo:
@ gcc mult.s && gdb a.out 
	.text
	.globl	main
main:
	LDR r0, =0x67654321
	LDR r1, =0x23110000
	BL	firstfunc
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
firstfunc:
	ADDS	r2, r0, r1 @ breakpoint aqui
	ADD	r3, r0, r1 @ breakpoint aqui
	MOV	pc, lr
