@ Planejamento
@ Para debugar este codigo:
@ gcc teste.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0x1

	ADDPL R7, R3, R6
	ADDMI R7, R3, R6

	MULHI R3, R7, R12
	MULLS R3, R7, R12

	CMPNE R6, R8
	CMPLE R6, R8

	swi 0x0
	
