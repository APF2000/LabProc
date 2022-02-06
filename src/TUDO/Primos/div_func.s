	.text
	.globl	main
main:


	ldr r1, =10773096 @ Dividendo (=10773096)
	ldr r2, =100   @ Divisor (=1000)
	mov r3, #0   @ Quociente
	mov r5, #0   @ Resto

	mov r6, #1	@ i = 1
	mov r7, #1	@ j = 1

	mov r8, #2	@ constante 32

	adr r11, .data	@ endereco respostas
	mov r9, #1	@ constante 1

	@
	@ x/20x $sp =====> para ver os registradores na memória
	@
loop1:
	cmp r6, r8	
	bge fim		@ se i >= 5 => acabou

	@ldr r7, =1	@ j = 1
	add r6, r6, #1	@ i++	
@loop2:

	sub r2, r2, #1	@ divisor--

	stmfd sp!, {r3, r5, r6, r7}

	stmfd sp!, {r1, r2}
	bl div				@ faz divisao
	ldmfd sp!, {r1, r2}		@ recupera dividendo e divisor

	str r3, [r11, r9, lsl #2]!			@ store na memoria
	
	mul r10, r3, r2 	
	add r10, r10, r5	@ resultado = quociente * divisor + resto
	cmp r10, r1		@ compara com o numero original
	beq continue1

	bl deu_pau		@ divisao foi feita errado

continue1:
	ldmfd sp!, {r3, r5, r6, r7}

	cmp r7, r8	
	b loop1	
	@bge loop1	@ se j >= 5 => acabou este loop

	@add r7, r7, #1	@ j++
	@b loop2		@ continua o loop

fim:
	swi 0x0






div:
	mov r3, #0   	@ Quociente da divisao
	mov r5, #0   	@ Resto da divisao

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
	
deu_pau:
	mov pc, lr

.data
