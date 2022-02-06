@ Exercicio 6.5.3 do livro
@ Para debugar este codigo:
@ gcc magic_squares.s && gdb a.out 
	.text
	.globl	main

main:
	MOV r0, #0x03;	@ N
	ADD r1, r0, #1; @ N+1
	MOV r2, #0x0;	@ constante = N(N*N+1)/2
	MOV r3, #0; 	@ contador i
	MOV r9, #0;	@ ehmagico
	MOV r6, #0;	@ S. soma da fila. Começa em 0

	ADR r10, quadrado;
	ADR r11, ehmagico;

	BL calcularConstante;	
	BL checkPrimeDiagonal;
	BL checkMagic;
	
	MOV r7, #1;	@ contador j
	MOV r6, #0;	@ zera S antes de continuar.
	BL checkSecondaryDiagonal;
	BL checkMagic;

	MOV r7, #0;	# contador de filas
	MOV r6, #0;	@ zera S antes de continuar.
	MUL r1, r0, r0;		@ r1=N²
	BL checkColumns;	

	MOV r7, #0;	# contador de filas
	MOV r6, #0;	@ zera S antes de continuar.
	BL checkRows;	
	
	MOV r9, #1;	@ ehmagico=1
	STR r9, [r11];	
	B fim;	

checkColumns:
	STMFD r13!, {lr};	@ PUSH lr into stack
	CMP r7, r0;

	BXEQ lr;
	MOV r3, r7; 	@ setta contador da coluna
	BL addColumn;
	BL checkMagic;
	MOV r6, #0;	@ zera S antes de continuar.
	ADD r7, r7, #1;

	LDMFD r13!, {lr};	@ POP lr back
	B checkColumns;

addColumn:
	CMP r3, r1;
	BXGT lr;
	BXEQ lr;
	MOV r4, r3, LSL #2; 	@ Multiplica i por 4 para indexar por palavra
	LDR r5, [r10, r4]; 	@ r5=array[i];
	ADD R6, R6, R5;		@ S+=r5;
	ADD r3, r3, r0; 	@ i+=N
	
	B addColumn;

checkRows:
	STMFD r13!, {lr};	@ PUSH lr into stack
	CMP r7, r0;	@ j(r7) indica a row atual. Uma vez que j=N, terminaram as rows.
	BXEQ lr;
	MUL r3, r7, r0; 	@ i(r3) conta o indice na array.
	BL addRow;
	BL checkMagic;
	MOV r6, #0;	@ zera S antes de continuar.
	ADD r7, r7, #1;
	LDMFD r13!, {lr};	@ POP lr back
	B checkRows;

addRow:
	ADD r4, r7, #1;		@ r4=j+1
	MUL r5, r0, r4;		@ r5=(j+1)N
	SUB r5, r5, #1;		@ r5=(j+1)N-1
	CMP r3, r5		@ se i>(j+1)N-1, chegou ao final da row
	BXGT lr;

	MOV r4, r3, LSL #2; 	@ Multiplica i por 4 para indexar por palavra
	LDR r5, [r10, r4]; 	@ r5=array[i];
	ADD R6, R6, R5;		@ S+=r5;
	ADD r3, r3, #1; 	@ i++
	
	B addRow;

checkMagic:
	CMP r6, r2;
	STRNE r9, [r11];	@ ehmagico=0
	BNE fim;	@ Se primeira diagonal já não for, pára.
	BX lr;

checkSecondaryDiagonal:
	CMP r7, r0;		@ ver se j > N
	BXGT lr;		@ se j > N, terminou o loop

	SUB r1, r0, #1;		@ r1=N-1
	MUL r4, r1, r7; 	@ r4=j(N-1)
	MOV r4, r4, LSL #2; 	@ Multiplica por 4 para indexar por palavra
	LDR r5, [r10, r4]	@ r5=array[i(N+1)]

	ADD r6, r5, r6;		@ S+=array[i(N+1)]

	ADD r7, r7, #1;		@ j++
	B checkSecondaryDiagonal	

checkPrimeDiagonal:
	CMP r3, r0;		@ ver se i > N
	BXEQ lr;		@ se i = N, terminou o loop
	
	MUL r4, r1, r3; 	@ r4=i(N+1)
	MOV r4, r4, LSL #2; 	@ Multiplica por 4 para indexar por palavra
	LDR r5, [r10, r4]	@ r5=array[i(N+1)]
	
	ADD r6, r5, r6;		@ S+=array[i(N+1)]

	ADD r3, r3, #1;		@ i++
	B checkPrimeDiagonal	


calcularConstante:
	MUL r2, r0, r0; 	@ r2=N²
	ADD r7, r2, #1; 	@ r7=N²+1
	MUL r8, r7, r0; 	@ r8=N(N²+1)
	MOV r2, r8, LSR #1; 	@ r2=N(N²+1)/2
	BX lr;
fim:
	SWI 0x123456;

quadrado:
	.word 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05;
	.align 3
	@.word 16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4, 15, 13, 1;
ehmagico:
	.word 0x0;
