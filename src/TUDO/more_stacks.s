@ Exercicio 6.5.4 do livro
@ Para debugar este codigo:
@ gcc more_stacks.s && gdb a.out 
	.text
	.globl	main
main:
	mov r2, #1 		@ 1 = byte, 2 = half-word, 4 = word
	ldr r1, =0x12345678	@ valor a ser armazenado
	mov r4, #1

	cmp r2, #2
	bllt byte		@ adiciona byte 
	bleq hword		@ adiciona half-word
	blgt word		@ adiciona word

	swi 0x0

byte:
	strb r1, [sp, r4, lsl #2]!	@ escreve byte no stack
	mov pc, lr

hword:
	strh r1, [sp, r4, lsl #2]!	@ escreve hword no stack
	mov pc, lr

word:
	str r1, [sp, r4, lsl #2]!	@ escreve word no stack
	mov pc, lr
	
