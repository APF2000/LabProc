.global _start
@.text

.text
.code 32
.global reset, vectors_start, vectors_end
.global lock, unlock

_start:
	b _Reset @posição 0x00 - Reset
	ldr pc, _undefined_instruction @posição 0x04 - Intrução não-definida
	ldr pc, _software_interrupt @posição 0x08 - Interrupção de Software
	ldr pc, _prefetch_abort @posição 0x0C - Prefetch Abort
	ldr pc, _data_abort @posição 0x10 - Data Abort
	ldr pc, _not_used @posição 0x14 - Não utilizado
	ldr pc, _irq @posição 0x18 - Interrupção (IRQ)
	ldr pc, _fiq @posição 0x1C - Interrupção(FIQ)
	
_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used

_irq: .word irq
_fiq: .word fiq

INTPND: .word 0x10140000 @Interrupt status register
INTSEL: .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN: .word 0x10140010 @interrupt enable register

KEYBOARD_BASE_ADDR: .word 0x1000600	@ endereco base do teclado e mouse
ENABLE_KEYBOARD_IRQ: .word 0x14		@ tem que ficar no registrador que esta em KEYBOARD_BASE_ADDR


_Reset:
reset_handler:
	@ entry point of program
	@ set SVC stack
	LDR sp, =svc_stack_top

	@ copy vector table to address 0
	@@@@@@@@@@@@@@@@@@@@@BL copy_vectors

	@ go in IRQ mode to set IRQ stack
	MSR cpsr, #0x92
	LDR sp, =irq_stack_top

	@ go back in SVC mode with IRQ interrupts enabled
	MSR cpsr, #0x13

	@ call main() in SVC mode
	BL main
	B .

undefined_instruction:
	b .

software_interrupt:
	b do_software_interrupt @vai para o handler de interrupções de software

prefetch_abort:
 	b .

data_abort:
 	b .

not_used:
 	b .

irq:
	b do_irq_interrupt @vai para o handler de interrupções IRQ

fiq:
	b .


do_software_interrupt: @Rotina de Interrupçãode software
	add r1, r2, r3 @r1 = r2 + r3
	mov pc, r14 @volta p/ o endereço armazenado em r14


do_irq_interrupt: 		@ Rotina de interrupções IRQ
	STMFD sp!, {r12}		@ r0 guarda o endereco onde ficarao os valores dos registradores

irq_handler:
	sub lr, lr, #4
	stmfd sp!, {r0-r12, lr} 	@ stack ALL registers
	@@@@@@@@@@@@bl IRQ_handler 			@ call IRQ_hanler() in C
	
	ldmfd sp!, {r0-r3, r12, pc}^ 	@ return
lock:
	MRS r0, cpsr
	ORR r0, r0, #0x80
	MSR cpsr, r0
	mov pc, lr
	@ mask out IRQ interrupts
	@ set I bit means MASK out IRQ interrupts64
unlock:
	@ mask in IRQ interrupts
	MRS r0, cpsr
	BIC r0, r0, #0x80

	@ clr I bit means MASK in IRQ interrupts
	MSR cpsr, r0
	mov pc, lr

	vectors_start:
		@ vector table: same as before
	vectors_end:

chaveando:
	
	ldmfd sp!, {r10, r11}			@ recupera r1 e r2 originais
	stmfa r12!, {r0-r11}			@ guarda em linhaA ou linhaB todos os registradores de proposito geral
	
	ldmfd sp!, {r9}				@ pega o topo da pilha (linhaA ou linhaB)
	ldmfd sp!, {r1}				@ pega o valor de r12, que agora esta no topo da pilha
	stmfa r12!, {r1}			@ guarda o valor original de r12 em linhaA ou linhaB 

	sub r0, lr, #4				@ pega o pc certo
	stmfa r12!, {r0}			@ guarda o pc

	mrs r1, cpsr 				@ salvando o modo corrente em R1
	msr cpsr_ctl, #0b11010011 		@ alterando para modo 13 (supervisor) => sp atual e o sp certo
	stmfa r12!, {sp}			@ guarda o sp correcto

	mov r2, lr				@ salva lr
	sub lr, lr, #4				@ tira 4 para acertar o lr
	stmfa r12!, {lr}			@ guarda o lr
	mov lr, r2				@ recupera lr

	mrs r2, cpsr				@ guarda o cpsr temporariamente
	@orr r2, r2, #0xc0			@ setar bits I = 0 e F = 0 (enable interrupt)
	stmfa r12!, {r2}			@ guarda o cpsr em linhaA

	msr cpsr_c, r1 				@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ volta para o modo anterior (interrupcao) 


	LDR r0, INTPND 				@Carrega o registrador de status de interrupção
	LDR r0, [r0]
	TST r0, #0x0010 			@verifica se é uma interupção de timer


	BLNE handler_timer 			@vai para o rotina de tratamento da interupção de timer
	
	add r9, r9, #68					@ soma o espaco alocado
	ldmfa r9!, {r0}					@ recupera cpsr atraves de r0
	msr spsr, r0					@ guarda o proximo cpsr pro ^ ter efeito
	msr cpsr_c, r0					@@@@@@@@@@@ volta pra o modo anterior

	ldmfa r9!, {sp, lr}				@ recupera sp e lr

	@msr cpsr_c, r2					@ volta para o modo guardado anteriormente em r2
		
	ldmfa r9!, {r0-r12, pc}^			@ pega o valor de todos os outros regs
	

handler_timer:

	@LDR r0, TIMER0X
	@MOV r1, #0x0
	@STR r1, [r0] @Escreve no registrador TIMER0X para limpar o pedido de interrupção

	stmfd sp!, {lr}			@ salva o lr na pilha
	BL print_interrupcao
	ldmfd sp!, {lr}			@ recupera o lr

	mov pc, lr @retorna


keyboard_init:
	@LDR r0, INTEN
	@LDR r1, =0x10 		@ bit 4 for timer 0 interrupt enable
	@STR r1, [r0]

	ldr r0, KEYBOARD_BASE_ADDR	@ endereco
	ldr r1, ENABLE_KEYBOARD_IRQ	@ valor a ser posto
	str r1, [r0]			@ habilita keyboard interrupt

	mrs r0, cpsr
	bic r0,r0,#0x80
	msr cpsr_c,r0 		@ enabling interrupts in the cpsr

	mov pc, lr


main:
	bl keyboard_init	@ configura teclado
task: 	
	bl print_p2		@ chama o print

	b task


