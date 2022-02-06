@ Exercicio 6.5.2 do livro
@ Para debugar este codigo:
@ gcc bubble.s && gdb a.out 
	.text
	.globl	main
main:
	ldr r0, =0xa 	 @ len = 10
	ldr r1, =0x4000  @ address list = *a

	str r0, [r1]	 @ a[-1] = len

	mov r2, #0	 @ indice do bubble = i
	add r3, r2, #1	 @ i + 1
	
loop1:
	cmp r3, r0
	bge end		   @ se i >= n : cheogu ao fim do vetor	

	ldrb r4, [r0], r2  @ operando1 = a[i]
	ldrb r5, [r0], r3  @ operando2 = a[i + 1]

	mov r6, r3	   @ j = i
	add r7, r6, #1	   @ j + 1


	add r2, r2, #1	   @ i++
	add r3, r3, #1	   @ i++
	
loop2:
	cmp r7, r0
	bge loop1	   @ se j >= len, volta para o loop maior

	cmp r4, r5
	blt loop2	   @ se op1 < op2 => não precisa fazer mais nada

	strb r5, [r0], r6  @ a[j] = operando2
	strb r4, [r0], r7  @ a[j + 1] = operando1

	add r6, r6, #1	   @ j++
	add r7, r7, #1	   @ j++

	b loop2	           @ continua o loop

end:
	swi 0x0
	
