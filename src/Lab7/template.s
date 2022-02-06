@ Exercicio x.y.z do livro
@ Para debugar este codigo:
@ gcc template.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0x1
	swi 0x0
	
