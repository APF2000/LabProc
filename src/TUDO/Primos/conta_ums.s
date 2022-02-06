@ Arthur Pires da Fonseca - 10773096

	.text
	.globl	main
main:
	ldr r0, =7	@ Numero cujos bits serao contados
	
	stmfd sp!, {r0}		@ Guarda r0 original
	bl conta_ums		@ Chama subrotina (apos isso o resultado estarah em r1)
	ldmfd sp!, {r0}		@ Recupera r0 original
fim:
	swi 0x0

conta_ums:
	ldr r1, =0x0		@ Contagem dos 1s
	ldr r3, =0x1		@ Constante 1
loop:
	cmp r0, #0	
	beq end_f		@ Se igual a zero, nao tem mais 1s
	
	and r2, r0, r3		@ Ve se bit menos significativo e 1 
	cmp r2, r3
	addeq r1, r1, r3	@ count++ se (num & mascara) == 1

	mov r0, r0, lsr	r3	@ num /= 2 (proximo bit anda)

	b loop			@ Continua a contar

end_f:
	mov pc, lr		@ Volta para a chamada
