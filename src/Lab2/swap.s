@ Exercicio 3.10.4 : algoritmo de SWAP usando XOR
@
@ Algoritmo
@ A = A XOR B
@ B = A XOR B
@ A = A XOR B
@
@ Para debugar este codigo:
@ gcc mult.s && gdb a.out 
	.text
	.globl	main
main:
	LDR r0, =0xF631024C
	LDR r1, =0x17539ABD
	EOR	r0, r0, r1 @ breakpoint aqui
	EOR 	r1, r0, r1 @ breakpoint aqui
	EOR 	r0, r0, r1 @ breakpoint aqui
	SWI	0x0
		
