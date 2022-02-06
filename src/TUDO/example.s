@ Exercicio x.y.z do livro
@ Para debugar este codigo:
@ gcc primeiro_load.s && gdb a.out 
	.text
	.globl	main
main:
	adr r0, main
	adr r1, data
	adrl r3, data+4300

	mov r0, #0x18
	ldr r1, 0x20026
	
	swi 0x0

data: 
	@% 8000
	@end
	
