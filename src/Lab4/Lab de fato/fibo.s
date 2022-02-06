@ Exercicio 4.5.5 do livro
@ Para debugar este codigo:
@ gcc fibo.s && gdb a.out 
    .text
    .globl    main
main:    
	LDR      	 r7, =0x0
	LDR     	 r8, =0x4000

	STRB    r7, [r8]
	LDR   	 r7, =0x1
	STRB    r7, [r8, #1]

	LDR   	 r0, =fibon
	LDR   	 r7, =fibon + 13
loop:    
	CMP   	 r7, r0
	BLE   	 out

	LDRB	r1, [r0], #1
	LDRB	r2, [r0]
	ADD   	r1, r2, r1
	STRB	r1, [r0, #1]

	B   	 loop
out:
    SWI 0x123456

fibon:
    .byte    0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0






