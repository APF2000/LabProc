/********* ts.s file ***********/
.text
.code 32
.global reset, vectors_start, vectors_end
.global lock, unlock
reset_handler: // entry point of program
// set SVC stack
LDR sp, =svc_stack_top
// copy vector table to address 0
BL copy_vectors
// go in IRQ mode to set IRQ stack
MSR cpsr, #0x92
LDR sp, =irq_stack_top
// go back in SVC mode with IRQ interrupts enabled
MSR cpsr, #0x13
// call main() in SVC mode
BL main
B .
irq_handler:
sub lr, lr, #4
stmfd sp!, {r0-r12, lr} // stack ALL registers
bl IRQ_handler // call IRQ_hanler() in C
ldmfd sp!, {r0-r3, r12, pc}^ // return
lock: // mask out IRQ interrupts
MRS r0, cpsr
ORR r0, r0, #0x80 // set I bit means MASK out IRQ interrupts
MSR cpsr, r0
mov pc, lr
unlock: // mask in IRQ interrupts
MRS r0, cpsr
BIC r0, r0, #0x80 // clr I bit means MASK in IRQ interrupts
MSR cpsr, r0
mov pc, lr
vectors_start:
// vector table: saame as before
vectors_end: