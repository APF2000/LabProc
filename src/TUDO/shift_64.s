	.text
	.globl	main
main:
	ldr r0, =0xa00aa00a @ Mais significativos
	ldr r1, =0xa00aa00a @ Menos significativos

	@ Shift de 1 para a esquerda
        movs r1, r1, lsl #1 @ Shift logico pra esquerda 
        mov r0, r0, lsl #1  @ Shift logico, mas mantendo o CPSR
	addcs r0, r0, #1    @ Adiciona um carry ao mais significativo se teve carry nos menos significativos
	
	@ Shift de 1 para a direita
	movs r0, r0, lsr #1 @ Shift logico pra direita 
	movs r1, r1, rrx @ Shift com bit mais significativo puxado do carry

        swi 0x0
	
