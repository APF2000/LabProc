.text
 .code 32
 
 .global vectors_start
 .global vectors_end
 
vectors_start:
 LDR PC, reset_handler_addr
 LDR PC, undef_handler_addr
 LDR PC, swi_handler_addr
 LDR PC, prefetch_abort_handler_addr
 LDR PC, data_abort_handler_addr
 B .
 LDR PC, irq_handler_addr
 LDR PC, fiq_handler_addr
 
reset_handler_addr: .word reset_handler
undef_handler_addr: .word undef_handler
swi_handler_addr: .word swi_handler
prefetch_abort_handler_addr: .word prefetch_abort_handler
data_abort_handler_addr: .word data_abort_handler
irq_handler_addr: .word irq_handler_entry
fiq_handler_addr: .word fiq_handler
 
vectors_end:

INTPND: .word 0x10140000 @Interrupt status register
INTSEL: .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN: .word 0x10140010 @interrupt enable register
TIMER0L: .word 0x101E2000 @Timer 0 load register
TIMER0V: .word 0x101E2004 @Timer 0 value registers
TIMER0C: .word 0x101E2008 @timer 0 control register
TIMER0X: .word 0x101E200c @timer 0 interrupt clear register 

qtde_subprocs: .word 0x0	@ quantidade de processos interrompidos
mem:
	.space 1024 @ pra dar espaco

handler_timer:

	LDR r0, TIMER0X
	MOV r1, #0x0
	STR r1, [r0] @Escreve no registrador TIMER0X para limpar o pedido de interrupção

	stmfd sp!, {lr}			@ salva o lr na pilha
	BL print_interrupcao
	ldmfd sp!, {lr}			@ recupera o lr

	mov pc, lr @retorna

timer_init:			@ configurar timer
	LDR r0, INTEN
	LDR r1,=0x10 	@ bit 4 for timer 0 interrupt enable
	STR r1,[r0]

	LDR r0, TIMER0C
	LDR r1, [r0]
	MOV r1, #0xA0 	@ enable timer module
	STR r1, [r0]

	LDR r0, TIMER0V
	LDR r1, =0xfff 	@ setting timer value
	STR r1,[r0]

	mrs r0, cpsr
	bic r0,r0,#0x80
	msr cpsr_c,r0 	@ enabling interrupts in the cpsr

	mov pc, lr
 
irq_handler_entry:

  	STMFD sp!, {r12}			@ r12 salvo pra depois

	mrs r12, cpsr 					@ salvando o modo corrente em R12
	orr r12, r12, #128				@ setar bit 7 em 1 => nao permitir interrupcoes
	msr cpsr_ctl, r12		 		@ incorpora modificacao no cpsr

	ldr r12, =mem				@ pegar endereco de MEM
		
	STMFD sp!, {r8, r9, r10, r11}	@ r11, r10 e r9 salvos pra depois
	ldr r9, =qtde_subprocs		@ endereco da qtde de subprocs
	ldr r10, [r9]				@ valor da qtde de subprocs (offset)
	mov r11, r10				@ valor da qtde de subprocs

	mov r8, #68					@ constante com a qtde de bytes dos regs
	mul r10, r10, r8			@ soma de bytes necessarios para guardar registradores = 68
	add r12, r12, r10			@ soma offset

	add r11, r11, #1			@ qtde de subprocs++
	str r11, [r9]				@ guarda de volta pra dizer que tem mais um subproc

	LDMFD sp!, {r8, r9, r10, r11}	@ r11, r10 e r9 pegos de volta

chaveando:
	
	stmfa r12!, {r0-r11}			@ guarda em linhaA ou linhaB todos os registradores de proposito geral
	
	@ldmfd sp!, {r9}				@ pega o topo da pilha = r12 antigo
	ldmfd sp!, {r1}				@ pega o valor de r12, que agora esta no topo da pilha
	stmfa r12!, {r1}			@ guarda o valor original de r12 em MEM

	sub r0, lr, #4				@ pega o pc certo
	stmfa r12!, {r0}			@ guarda o pc

	mrs r1, cpsr 				@ salvando o modo corrente em R1
	msr cpsr_ctl, #0b11010011 		@ alterando para modo 13 (supervisor, OBS: nao permite interupcoes) => sp atual e o sp certo
	stmfa r12!, {sp}			@ guarda o sp correcto

	mov r2, lr				@ salva lr
	sub lr, lr, #4				@ tira 4 para acertar o lr
	stmfa r12!, {lr}			@ guarda o lr
	mov lr, r2				@ recupera lr

	mrs r2, cpsr				@ guarda o cpsr temporariamente
	orr r2, r2, #128			@ setar bits I = 0 e F = 0 (enable interrupt) => quando for pego, vai poder receber interrupcao
	stmfa r12!, {r2}			@ guarda o cpsr em MEM

	msr cpsr_c, r1 				@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ volta para o modo anterior (interrupcao) 

trata_interrupcao:
	LDR r0, INTPND 				@Carrega o registrador de status de interrupção
	LDR r0, [r0]
	TST r0, #0x0010 			@verifica se é uma interupção de timer

	bne timer
	b irq

timer:
	blne handler_timer			@ eh de timer
	b recupera_registradores					

irq:
	bleq irq_handler			@ nao eh de timer
	b recupera_registradores

recupera_registradores:
	ldr r12, =mem					@ pega endereco da MEM de novo
	
	ldr r9, =qtde_subprocs		@ endereco da qtde de subprocs
	ldr r10, [r9]				@ valor da qtde de subprocs (offset)
	
	mov r11, r10				@ pega valor qtde de subprocs
	sub r11, r11, #1			@ tira 1 (tirou subproc da espera)
	str r11, [r9]				@ notifica isso pra memoria

	mov r8, #68					@ constante com a qtde de bytes dos regs
	mul r10, r10, r8			@ soma de bytes necessarios para guardar registradores = 68
	add r12, r12, r10			@ soma offset
	@add r12, r12, r8			@ soma o espaco alocado
	
	ldmfa r12!, {r0}					@ recupera cpsr atraves de r0
	bic r0, r0, #128				@ limpa bit 7 => habilitar interupcoes
	msr spsr, r0					@ guarda o proximo cpsr pro ^ ter efeito
	eor r0, r0, #128				@ seta bit 7 => desabilitar interupcoes (ipedir interrupcao entre MSR e LDMFA)
	msr cpsr_c, r0					@ volta pra o modo anterior

	ldmfa r12!, {sp, lr}				@ recupera sp e lr

volta_pra_onde_tava:	
	ldmfa r12!, {r0-r12, pc}^			@ pega o valor de todos os outros regs
	

reset_handler:

 /* set Supervisor stack */
 LDR sp, =stack_top

 /* copy vector table to address 0 */
 BL copy_vectors

 /* get Program Status Register */
 MRS r0, cpsr

 /* go in IRQ mode */
 BIC r1, r0, #0x1F
 ORR r1, r1, #0x12
 MSR cpsr, r1

 /* set IRQ stack */
 LDR sp, =irq_stack_top

 /* Enable IRQs */
 BIC r0, r0, #0x80

 /* go back in Supervisor mode */
 MSR cpsr, r0

 /* jump to main */
 bl timer_init


 BL main
 B .
 
.end
