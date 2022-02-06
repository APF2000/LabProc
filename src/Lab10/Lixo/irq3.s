
do_software_interrupt: @ Rotina de Interrupçãode software
	add r1, r2, r3 @r1 = r2 + r3
	mov pc, r14 @volta p/ o endereço armazenado em r14

do_irq_interrupt: @Rotina de interrupções IRQ
	STMFD sp!, {r0 - r3, LR} @Empilha os registradores

	LDR r0, INTPND @Carrega o registrador de status de interrupção
	LDR r0, [r0]
	TST r0, #0x0010 @verifica se é uma interupção de timer

	BLNE handler_timer @vai para o rotina de tratamento da interupção de timer
	LDMFD sp!, {r0 - r3,lr} @retorna

	sub lr, lr, #4	@ corrigindo o lr
	mov pc, r14

handler_timer:
	STMFD sp!,{R0-R12,pc}

	LDR r0, TIMER0X
	MOV r1, #0x0
	STR r1, [r0] @Escreve no registrador TIMER0X para limpar o pedido de interrupção

	@ Inserir código que sera executado na interrupção de timer aqui (chaveamento de processos, ou alternar LED por exemplo)
	@@@@@@@@@@@@@LDMFD sp!, {r0 - r3,lr}

	LDMFD sp!,{R0-R12,pc}^
	mov pc, r14 @retorna


timer_init:
	LDR r0, INTEN
	LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
	STR r1,[r0]

	LDR r0, TIMER0C
	LDR r1, [r0]
	MOV r1, #0xA0 @enable timer module
	STR r1, [r0]

	LDR r0, TIMER0V
	MOV r1, #0xff @setting timer value
	STR r1,[r0]

	@ Deslocado dali de cima
	mrs r0, cpsr
	bic r0,r0,#0x80
	msr cpsr_c,r0 @enabling interrupts in the cpsr

	mov pc, lr



main:
	bl timer_init @initialize interrupts and timer 0
	stop: b stop
