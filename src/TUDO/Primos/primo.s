@ Arthur Pires da Fonseca - 10773096

	.text
	.globl	main
main:

	ldr r1, =10773107 @ Numero que sera verificado @ 10773107 e primo

	stmfd sp!, {r1}
	bl ehprimo
	ldmfd sp!, {r1}

fim:
	swi 0x0

ehprimo:
	adr r0, primos	@ Endereco numeros primos

	mov r4, #2	@ Ultimo primo
	mov r8, #1	@ Indice do ult primo no vetor = id_prim

	mov r7, #0	@ Default: nao e primo

	cmp r1, #1	
	ble end_p	@ 1 nao e primo

loop_p1:
	stmfd sp!, {r6}

	mul r6, r4, r4
	cmp r6, r1
	movgt r7, #1	@ E primo
	bgt end_p	@ Se o ultimo primo passou da raiz quadrada do numero, e primo

	ldmfd sp!, {r6}

	mov r2, r4   	@ Divisor da divisao
	mov r3, #0   	@ Quociente da divisao
	mov r5, #0   	@ Resto da divisao

	stmfd sp!, {r0-r4, lr}	@ Guarda vars
	bl div
	ldmfd sp!, {r0-r4, lr}	@ Recebe de volta

	cmp r5, #0
	beq end_p	@ Nao e primo, de fato

	add r4, r4, #1	@ Proximo numero primo (ou nao)

	stmfd sp!, {r1-r3, r5-r7, lr}

	mov r1, r4			@ Verificar se o num atual e primo
	@bl ehprimo
	cmp r7, #1			@ E primo?
	streq r4, [r0, r8, lsl #2]	@ Guarda numero primo no vetor
	addeq r8, r8, #1		@ id_prim++

	ldmfd sp!, {r1-r3, r5-r7, lr}

	b loop_p1	@ Continua o loop

end_p:
	mov pc, lr


div:
	mov r4, #0   @ Tamanho do shift
	mov r0, r2   @ Guarda o valor inicial do divisor

	@ Divisao
	@ Alinhar bits mais à esquerda

align:	
	mov r2, r2, lsl #1   
	cmp r2, r1   
	ble align    @ r2 (divisor) < r1 (dividendo) => continua

div_loop:
	cmp r1, r2 
	bge quociente_1 @ r1 (dividendo) >= r2 (divisor) ?
  	b quociente_0
loop_end:
	mov r2, r2, lsr #1 @ Desloca para a direita o divisor
	cmp r1, r0
	blt end @ r1 (dividendo) < r0 (divisor original) => acabou divisão
	b div_loop @ Senao, continua o loop

quociente_1:
	sub r1, r1, r2 @ Tira o divisor do dividendo
	mov r3, r3, lsl #1 @ Desloca o quociente
	add r3, r3, #1 @ Adiciona um 1 ao fim do quociente
	b loop_end
	
quociente_0:
	mov r3, r3, lsl #1
	b loop_end

end:	
	cmp r2, r0
	blt end2           @ Se o divisor voltou ao valor original, nao tem mais o que fazer
	mov r2, r2, lsr #1 @ Divide divisor por 2
	mov r3, r3, lsl #1 @ Multiplica o quociente por 2
	b end              @ Continua o loop 	

end2:
	mov r5, r1 @ Copia o dividendo para o resto	
	mov pc, lr @ Volta para a chamada da função
	
primos:
	.word 2

