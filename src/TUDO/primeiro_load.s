@ Exercicio x.y.z do livro
@ Para debugar este codigo:
@ gcc primeiro_load.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0x24 	@ Linhas abaixo para fazerem o load na memoria

	ldr r1, =0x06
	str r1, [r0], #0

	ldr r1, =0xf5
	str r1, [r0], #1

	ldr r1, =0x3
	str r1, [r0], #2

	ldr r1, =0xff
	str r1, [r0], #3

	ldr r0, =0x24 @ Offset da primeira palavra

	@ Instrucoes do enunciado
	LDRSB sp, [r0]
	LDRSH sp, [r0]
	LDR sp,[r0]
	LDRB sp,[r0]


	swi 0x0
	
