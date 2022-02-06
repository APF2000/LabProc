@ Exercicio x.y.z do blog
@ Para debugar este codigo:
@ gcc int2str.s && gdb a.out 

	.text
	.globl	main
int2str: 
	@ Recebe os argumentos pelos registradores r0 e r1
	@ r0 = inteiro (em hexadecimal)
	@ sp -> pontstr

	mov r2, =0xf		@ constante 15 (mascara de 4 bits)

	ldmfd sp, {r1}		@ Pega ponteiro pra string
loop:
	and r3, r2, r0		@ pega 4 bits menos significativos
	add r3, r3, =0x30	@ soma 

	cmp r0, #0
	bgt loop		@ continua o loop se numero nao foi descascado totalmente
	mov pc, lr		@ acabou a funcao	


@loop:
@	stmfd sp!, {r0-r5}	@ Guarda na pilha
@
@	mov r1, r0		@ dividendo = num
@	mov r2, #10		@ divisor = 10
@	bl div			@ r3 = num / 10, r5 = num % 10
	
	
fim:
	mov pc, lr		@ Finaliza funcao


div: @ r1 dividendo, r2 divisor
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
	
