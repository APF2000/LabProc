@ Exercicio 6.5.2 do livro
@ Para debugar este codigo:
@ gcc bubble.s && gdb a.out 
	.text
	.globl	main

swap:
	STRB r5, [r1,r9]	@ array[j]=array[j+1]
	STRB r3, [r1,r4]	@ array[j+1]=array[j]
	BX lr;

end:
	SWI 0x123456

innerLoop:
	STMFD r13!, {lr};	@ PUSH lr into stack
	
	SUB r11, r2, r8
	SUB r11, r11, #1 	@ Calcula n-i-1
	CMP r9, r11		@ Continua se j<n-i-1
	BXEQ lr			@ Se j=n-i-1, volta ao loop externo.
	
	LDRB r3, [r1, r9] 	@ r3=array[j]
	ADD r4, r9, #1 		@ r4=j+1
	LDRB r5, [r1, r4] 	@ r5=array[j+1]
	
	CMP r3, r5;

	
	BLGT swap		@ if(array[j] > array[j+1]) swap()

	@ increment
	ADD r9, r9, #1;	@ j++

	LDMFD r13!, {lr};	@ POP lr back
	B innerLoop	
	
outerLoop:
	CMP r8, r2	@ Continua se i<n
	BEQ end		@ Se i=n, termina

	BL innerLoop
	
	ADD r8, r8, #1;	@ i++	@ increment i
	MOV r9, #0x0;	@ j=0	@ restart j

	B outerLoop	

main:
	LDR r0, =0x4000	@ endereço do tamanho da array
	ADR r1, array;

	MOV r2, #0x8 	@ array de 8 endereços
	STRB r2, [r0]	@ mem[0x4000]=8
	
	MOV r8, #0x0;	@ i=0
	MOV r9, #0x0;	@ j=0

	B outerLoop	

array:	.byte 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01;
	


	


