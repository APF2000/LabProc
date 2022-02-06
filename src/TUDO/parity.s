@ Exercicio 5.5.5 do livro
@ Para debugar este codigo:
@ gcc parity.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0b1101		@ sequencia de paridade
	mov r1, #0

	mov r2, #32		@ count = 32
	mov r3, #1		@ mask

loop:
	and r4, r0, r3		@ count-esimo bit
	mov r0, r0, lsr #1	@ tira o ultimo bit da sequencia
	
	subs r4, r4, r3		@ tira 1 do bit
	addeq r1, r1, #1	@ muda a paridade

	subs r2, r2, #1		@ count--
	bne loop		@ continua se count != 0

	and r1, r1, r3
	swi 0x0
	
