@ Exercicio x.y.z do livro
@ Para debugar este codigo:
@ gcc pre_pos.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0x1
	mov     r2, #1
	@ Byte loads
	adr     r0, bytes
	ldrb    r3, bytes       @ r3= bytes[0];     // r3= 0x000000FF= 255
	ldrsb   r3, bytes       @ r3= (s8)bytes[0]; // r3= 0xFFFFFFFF= -1
	@ldrb    r3, [r0], r2    @ r3= *r0_b++;      // r3= 255, r0++;
	ldrb    r3, [r0, r2]

	@ Halfword loads
	adr     r0, hwords
	ldrh    r3, hwords+2    @ r3= words[1];     // r3= 0x0000FFFF= 65535
	ldrsh   r3, [r0, #2]    @ r3= (s16)r0_h[1]; // r3= 0xFFFFFFFF= -1
	@ldrh    r3, [r0, r2, lsl #1]    @ r3= r0_h[1]? No! Illegal instruction :(


	swi 0x0

	@ Byte array: u8 bytes[3]= { 0xFF, 1, 2 };
bytes:
	.byte   0xFF, 1, 2
	@ Halfword array u16 hwords[3]= { 0xF001, 0xFFFF, 0xF112 };
	.align  1    @ align to even bytes REQUIRED!!!
hwords:
	.hword  0xF110, 0xFFFF, 0xF112
