@ Exercicio 5.5.2 do livro
@ Para debugar este codigo:
@ gcc fatorial.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0x0

factorial: 
	MOV r6,#0xA 		@ load 10 into r6

	MOV r4, r6 		@ copy n into a temp register

loop: 	
	SUBS r4, r4, #1 	@ decrement next multiplier


	MULNE r6, r4, r6 	@ perform multiply
	MOVNE r0, r6	 	@ save off product for another loop
	BNE loop 		@ go again if not complete

	swi 0x0
	
