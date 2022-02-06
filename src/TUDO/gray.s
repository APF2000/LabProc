@ Exercicio 3.10.8 da apostila
@ Para debugar este codigo:
@ gcc grey.s.s && gdb a.out 
@ Codigo grey exemplo: 000 001 011 010 110 111 101 100
@ Grey 2: 10 11 01 00
@ Algoritmo: 0 10, 0 11, 0 01, 0 00, 1 00, 1 01, 1 11, 1 10
@ 10 11 01 00 = 0xb4
@ VIRA
@ 100 101 111 110 010 011 001 000 = 1001 0111 1110 0100 1100 1000 = 0x97e4c8	
	.text
	.globl	main
main:
	ldr r0, =1	    @ Constante 1

	ldr r1, =0x000000b4 @ Codigo grey de 2 bits
	ldr r2, =0	    @ Futuro codigo grey de 3 bits

	ldr r3, =0x00000003 @ Mascara para pegar 2 bits
	ldr r4, =0          @ Contador de bits para shift no codigo original
	ldr r7, =0	    @ Contador de bits para shift no codigo futuro
	ldr r5, =2          @ Qtde de bits do codigo grey original
	ldr r8, =3	    @ Qtde de bits do codigo grey futuro
	
	ldr r9, =0	    @ Guarda r5 temporariamente	

	ldr r6, =0	    @ Contem o valor dos bits que importam

loop1:	
	and r6, r1, r3, lsl r4   @ AND entre mascara e codigo, pega so os bits que importam
	mov r6, r6, lsr r4       @ Shift de (bits do grey) posicoes
	add r2, r2, r6, lsl r7   @ Soma ao grey do futuro 

	add r4, r4, r5      @ Soma a qtde de bits originais de grey ao contador
	add r7, r7, r8      @ Soma os bits futuros

	mov r9, r5	    @ Guarda o valor de r5
	mov r5, r0, lsl r5  @ Sobrescreve com o valor do shift (1 * 2^(bits do grey))
	cmp r4, #8 @r0, lsl r5  @ Ve se r4 e maior que 2^(bits do grey)
	mov r5, r9          @ Recupera valor de r5

	blt loop1           @ Continua o loop se contador < 2^(bits do grey)
loop2:	
	sub r4, r4, r5
	@sub r7, r7, r8

	and r6, r1, r3, lsl r4 @ Mesmo codigo de cima
	mov r6, r6, lsr r4
	
	add r6, r6, r0, lsl r5 @ Soma 100 (qtde de zeros necessarias) pra fazer um complemento do loop1
	add r2, r2, r6, lsl r7

	@sub r4, r4, r5
	add r7, r7, r8

	cmp r4, #0 @ Acho que e zero
	
	bgt loop2 @ Se for maior do que zero ainda	
	
	swi 0x0
	
