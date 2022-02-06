@ Exercicio 4.5.4.B do livro
@ Para debugar este codigo:
@ gcc arrays_n_ptrs_b.s && gdb a.out 
	.text
	.globl	main
main:
	adr r3, .a 	@ p = &a[0]
	ldr r0, =0x0	@ aux = 0

	@adr r1, .a	@ a[]
	mov r2, #10 	@ s = 10
	add r1, r3, r2 	@ r1 = &a[0] + s = &a[s]
	
LOOP:
	@ condition
	CMP r3, r1 	@ p VS &a[s]
	
	@ body
	strb r0, [r3] 	@ *p = 0
	
	@ increment
	ADD r3, r3, #1	@ p++

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
