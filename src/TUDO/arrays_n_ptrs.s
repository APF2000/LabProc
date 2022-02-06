@ Exercicio 4.5.4.A do livro
@ Para debugar este codigo:
@ gcc arrays_n_ptrs.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r3, =0x0 	@ i = 0
	ldr r0, =0x0	@ aux = 0

	adr r1, .a	@ a[]
	mov r2, #10 	@ s = 10
	
LOOP:
	@ condition
	CMP r3, r2 	@ i VS s
	
	@ body
	strb r0, [r1, r3] @ a[i] = 0
	
	@ increment
	ADD r3, r3, #1	@ i++

	BLT  LOOP
	
	swi 0x0

.a:	
	.byte 0x01 @ a[0]
	.byte 0x02 @ a[1]
	.byte 0x03 @ a[2]
	.byte 0x04 @ a[3]

	.byte 0x05 @ a[4]
	.byte 0x06 @ a[5]
	.byte 0x07 @ a[6]
	.byte 0x08 @ a[7]

	.byte 0x09 @ a[8]
	.byte 0x0a @ a[9]

	.align 1
