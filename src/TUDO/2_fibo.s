@ Exercicio 4.5.6 do livro
@ Para debugar este codigo:
@ gcc 2_fibo.s && gdb a.out 
    .text
    .globl    main
main:    
	LDR r7, =0x0
	LDR r8, =0x4000
	MOV r1, #11
	SUB r1, r1, #1 @ Tira 1 pro indice ficar certo

	STRB    r7, [r8]
	LDR   	r7, =0x1
	STRB    r7, [r8, #1] 

	LDR   	 r3, =fibon @ end atual
	ADD   	 r7, r3, r1 @ end do ultimo
loop:    

	LDRB	r4, [r3], #1
	LDRB	r2, [r3]
	ADD   	r0, r2, r4
	STRB	r0, [r3, #1]

	CMP   	 r3, r7
	BLT   	 loop

	B   	 out

out:
    SWI 0x123456


fibon:
    .byte    0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0






