@ Exercicio 5.5.4.1 do livro
@ Para debugar este codigo:
@ gcc fsm.s && gdb a.out 
	.text
	.globl	main
main:
	@ldr r1, =0xb0b0b0b0  	@ input X
	ldr r1, =0xb6db00b6
	
	mov r2, #0		@ output Z
	
	ldr r3, =0xb		@ pattern
	@ldr r9, =0xf		@ mask

	mov r4, #1		@ aux = 1

	mov r0, #0		@ last_time = false
	ldr r8, =0x80000000	@ limit pattern
	

loop:
	@and r5, r1, r9		@ X AND mask	
	@subs r5, r5, r3		@ X modified - pattern
	@addeq r2, r2, r4	@ if(found pattern) Z += aux

	sub r5, r1, r3		@ X - pattern
	ands r5, r5, r3		@ match mask and hole
	addeq r2, r2, r4	@ if(found pattern) Z += aux

	mov r4, r4, lsl #1	@ aux *= 2
	mov r3, r3, lsl #1	@ pattern shift
	@mov r9, r9, lsl #1	@ mask shift

	cmp r0, #1
	beq end			@ if(last_time) goto end

	cmp r3, r8		@ pattern big enough?
	movcs r0, #1		@ last_time = true 

	b loop

end:
	swi 0x0
	
