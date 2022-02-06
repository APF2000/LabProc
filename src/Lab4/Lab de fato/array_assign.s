@ Exercicio 4.5.3 do livro
@ Para debugar este codigo:
@ gcc array_assign.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r3, =0x0 @ i = 0
	ldr r4, =0x4 @ c = 4

	adr r1, .a
	adr r2, .b
	
LOOP:
	@ condition
	CMP r3, #9
	
	@ body
	LDR r5, [r2, r3, LSL #2] @ r5 = b[i]
	add r5, r5, r4		 @ r5 = b[i] + c
	STR r5, [r1, r3, LSL #2] @ a[i] = r5
	
	@ increment
	ADD r3, r3, #1	@ i++
	BLT  LOOP
	
	swi 0x0
	

.a:	
	.word 0xff00ff00 @ a[0]
	.word 0xff00ff00 @ a[1]
	.word 0xff00ff00 @ a[2]
	.word 0xff00ff00 @ a[3]
	.word 0xff00ff00 @ a[4]
	.word 0xff00ff00 @ a[5]
	.word 0xff00ff00 @ a[6]
	.word 0xff00ff00 @ a[7]
	.word 0xff00ff00 @ a[8]
	.word 0xff00ff00 @ a[9]

.b:	
	.word 0x12345678 @ b[0]
	.word 0x87654321 @ b[1]
	.word 0xff00ff00 @ b[2]
	.word 0xff00ff00 @ b[3]
	.word 0xff00ff00 @ b[4]
	.word 0xff00ff00 @ b[5]
	.word 0xff00ff00 @ b[6]
	.word 0xff00ff00 @ b[7]
	.word 0xff00ff00 @ b[8]
	.word 0xff00ff00 @ b[9]
	
