@ Exercicio x.y.z do livro
@ Para debugar este codigo:
@ gcc template.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0x0 		@ i = 0
	adr r1, main 		@ sub r1, pc, #offset do main
	adrl r2, data  		@ endereço de a[0] relativos ao pc
	adrl r3, data + 4000 	@ endereço de b[0]

for:
	sub r7, r0, #7
	sub r7, r7, r7, lsl #1	@ aux = (i - 7) * (1 - 2)

	ldr r4, [r3, r7]		@ aux2 = b[7 - i]
	str r4, [r2, r0]	 	@ a[i] = aux2

	add r0, r0, #1		@ i++
	cmp r0, #8
	blt for			@ continua loop se i < 8

	swi 0x0
	
data:
	mov r0, r0
