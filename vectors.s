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

	@mov pc, lr
 
irq_handler_entry:

	LDR r0, INTPND 				@Carrega o registrador de status de interrupção
	LDR r0, [r0]
	TST r0, #0x0010 			@verifica se é uma interupção de timer

	blne handler_timer


	@LDR r0, INTPND 				@Carrega o registrador de status de interrupção
	@LDR r0, [r0]
	@TST r0, #0x0010 			@verifica se é uma interupção de timer

	bleq irq_handler
  

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
