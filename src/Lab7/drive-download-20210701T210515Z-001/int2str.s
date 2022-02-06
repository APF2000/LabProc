@ Exercicio x.y.z do blog
@ Para debugar este codigo:
@ gcc int2str.s && gdb a.out 

	.text
	.globl	int2str
int2str: 
	@ Recebe os argumentos pelos registradores r0 e r1
	@ r0 = inteiro (em hexadecimal) 0x12344321 -> 
	@ sp -> pontstr

	ldr r2, =0xf		@ constante 15 (mascara de 4 bits)
	ldr r4, =0x30;
	ldr r5, =0x1;
	ldmfd sp, {r1}		@ Pega ponteiro pra string
	mov r9, r1;
	
loop:
	and r3, r2, r0		@ pega 4 bits mais significativos
	add r3, r3, r4		@ soma 30 para transformar em ascii
	strb r3, [r1], #0
	add r1, r1, r5
	mov r0, r0, lsr #4	@ divide por 16 para colocar o próximo no menos sig.

	cmp r0, #0
	bgt loop		@ continua o loop se numero nao foi descascado totalmente
	mov r3, #0
	strb r3, [r1], #0	@ coloca 0 no final
	add r1, r1, r5
	mov r1, r9;
	mov pc, lr		@ acabou a funcao	


