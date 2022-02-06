.global _start
.text
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

INTPND:  .word 0x10140000 @Interrupt status register
INTSEL:  .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN:   .word 0x10140010 @interrupt enable register
TIMER0L: .word 0x101E2000 @Timer 0 load register
TIMER0V: .word 0x101E2004 @Timer 0 value registers
TIMER0C: .word 0x101E2008 @timer 0 control register
TIMER0X: .word 0x101E200c @timer 0 interrupt clear register

_Reset:
 LDR sp, =stack_top

 MRS r0, cpsr
 MSR cpsr_ctl, #0b11010010
 LDR sp, =irq_stack_top
 MSR cpsr, r0
 
 LDR r0, =current_process @ processo atual é o A
 LDR r1, =0
 STR R1, [r0]

 LDR r0, =linhaB
 ADR r1, first
 STMFD r0!, {r1} @ salvei pc
 LDR r1, =0
 LDR r2, =0
 LDR r3, =0
 LDR r4, =0
 STMFD r0!, {r1-r4}
 STMFD r0!, {r1-r4}
 STMFD r0!, {r1-r4}
 STMFD r0!, {r1}
 LDR r1, =pilhaB
 LDR r2, =0
 LDR r3, =0b00010011
 STMFD r0!, {r1-r3} @ salvei spsr, lr, sp
 

 bl main
 b .

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

do_software_interrupt: @Rotina de Interrupção de software
 add r1, r2, r3 @r1 = r2 + r3
 mov pc, r14 @volta p/ o endereço armazenado em r14


do_irq_interrupt: @Rotina de interrupções IRQ
 SUB r14, r14, #4
 bl print_hash

 STMFD sp!, {r0, r1} @ salva o r0, r1 na pilha sp
 LDR r0, =current_process @ carrega o processo atual
 LDR r1, [r0]
 CMP r1, #1 @ verifica qual pilha deve carregar
 LDREQ r0, =linhaB
 LDRNE r0, =linhaA

 STMFD r0!, {lr} @ salva o pc na pilha linhaA
 STMFD r0!, {r2-r12} @ salva r2-r12 na pilha linhaA
 LDMFD sp!, {r2-r3} @ desempilha r0 e r1
 STMFD r0!, {r2-r3} @ salva r0 e r1
 MRS r1, spsr
 STMFD r0!, {r1} @ salva o spsr na pilha sp
 ORR r1, r1, #128
 MRS lr, cpsr
 STMFD r0!, {lr} @ empilha cpsr para voltar ao modo dps
 MSR cpsr_ctl, r1 @ #0b11010011
 LDMFD r0!, {r1}
 STMFD r0!, {sp, lr} @empilha sp, lr em linhaA do modo supervisor
 MSR cpsr_ctl, r1 @ #0b11010010 @ volta para o modo interrupt, mas sem interrupções ativas
 
 @Salvar processo anterior
 LDR r12, INTPND @Carrega o registrador de status de interrupção
 LDR r12, [r12]
 TST r12, #0x0010 @verifica se é uma interupção de timer
 STMFD sp!, {r0} @ salva o topo da pilha do processo
 BLNE handler_timer @vai para o rotina de tratamento da interupção de timer 
 
 LDMFD sp!, {r0} @ recupera o topo da pilha do processo
 LDMFD r0!, {r3-r5}   @ desempilha lr, sp e spsr, para alterar lr e sp no outro modo

 MRS r1, cpsr
 EOR r6, r5, #128
 MSR cpsr_ctl, r6
 MOV sp, r3
 MOV lr, r4
 MSR cpsr, r1

 MSR spsr, r5         @ altera spsr
 LDMFD r0, {r0-r12, pc}^  @ chaveia o processo

handler_timer:
 LDMFD sp!, {r0} @ retira da pilha um elemento que nao sera utilizado

 LDR r0, TIMER0X
 MOV r1, #0x0
 STR r1, [r0] @Escreve no registrador TIMER0X para limpar o pedido de interrupção

 LDR r3, =current_process @ carrega o processo atual
 LDR r2, [r3]

 CMP r2, #0 @ verifica qual pilha deve carregar
 LDREQ r0, =linhaB - 68
 LDREQ r2, =1
 STREQ r2, [r3]
 LDRNE r0, =linhaA - 68
 LDRNE r2, =0
 STRNE r2, [r3]
 
 LDMFD r0!, {r3-r5}   @ desempilha lr, sp e spsr, para alterar lr e sp no outro modo

 MRS r1, cpsr
 EOR r6, r5, #128
 MSR cpsr_ctl, r6
 MOV sp, r3
 MOV lr, r4
 MSR cpsr, r1

 MSR spsr, r5         @ altera spsr
 LDMFD r0, {r0-r12, pc}^  @ chaveia o processo


timer_init:
 LDR r0, INTEN
 LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
 STR r1,[r0]
 LDR r0, TIMER0L
 LDR r1, =0xff @setting timer value
 STR r1,[r0]
 LDR r0, TIMER0C
 MOV r1, #0xE0 @enable timer module
 STR r1, [r0]
 mrs r0, cpsr
 bic r0,r0,#0x80
 msr cpsr_c,r0 @enabling interrupts in the cpsr
 mov pc, lr

main:
 bl timer_init @initialize interrupts and timer 0
stop: bl second_process
 b stop
first: bl first_process
 b first
