@ Exercicio 3.10.3 : shift de 5 : multiplicar por 32
@ Para debugar este codigo:
@ gcc mult.s && gdb a.out 
	.text
	.globl	main
main:
	LDR r0, =0X00000001 
	MOV r1, r0, lsl #5 @ breakpoint aqui
	SWI	0x00
