@ Exercicio 4.5.1 do livro
@ Para debugar este codigo:
@ gcc load_store_pos.s && gdb a.out

     .text
    .globl	main
main:
	MOV r1, #0x2    	@ y qualquer
	ADR r2, arr     	@ salva end inicial em r2
	ADD r3, r2, #20  	@ salva o endereço de array[5] em r3
	LDR r4, [r3], #0	@ salva o valor de array[5] em r4
	ADD r0, r1, r4  	@ salva array[5] + y em r0
	ADD r3, r2, #40 	@ salva o endereçco de array[10] em r3
	STR r0, [r3]    	@ salve o valor de r0 no enderço de r3
	SWI 0x0

arr:
	.word   0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3, 0x0, 0x1, 0x2, 0x3
