	/*  */	
	/* 	Arthur Pires da Fonseca, NUSP: 10773096 */	
	/* 	Para rodar os arquivos do exercício X:  */	
	/* 	eabi-gcc test.c -o test.o  */	
	/* 	eabi-as startup.s -o startup.o  */	
	/* 	eabi-ld -T vector_table.ld test.o startup.o -o program.elf  */	
	/* 	eabi-bin program.elf program.bin  */	
	/* 	qemu program.bin */	
	/* 	 */	
.section INTERRUPT_VECTOR, "x"
.global _Reset
_Reset:
  B Reset_Handler /* Reset */
  B Undefined_Handler /* Undefined */
  B . /* SWI */
  B . /* Prefetch Abort */
  B . /* Data Abort */
  B . /* reserved */
  B . /* IRQ */
  B . /* FIQ */

Reset_Handler:
  LDR sp, =stack_top
  MRS r0, cpsr
  MSR cpsr_ctl, #0b11011011
  LDR sp, =undefined_stack_top
  MSR cpsr, r0
  .word 0xffffffff
  BL c_entry
  B .

Undefined_Handler:
  STMFD sp!, {r0-r12, lr}
  B undefined
  LDMFD sp!, {r0-r12, pc}^
