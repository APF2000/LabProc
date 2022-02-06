@ Arthur Pires da Fonseca - 10773096

	.text
	.globl	main
main:

	ldr r0, =8000 		@ Dividendo

	mov r1, r0		@ Passa o dividendo para o reg usado na subrotina
	ldr r2, =16   		@ Divisor (=16)
	mov r3, #0   		@ Quociente
	mov r5, #0   		@ Resto

	stmfd sp!, {r0}
	bl div
	ldmfd sp!, {r0}

	mov r1, r3		@ r1 = quociente

fim:
	swi 0x0




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

