	.text
	.globl	main
main:

	@STMIA r5!, {r5, r4, r9}
	@LDMDA r2, {}
	@STMDB r15!, [r0-r3, r4, lr}

	LDR r6, =0x8000
	@LDMIA r6!,{r0,r4,r7,lr}
	LDMIA r6,{r7,r4,r0,lr}

	
	LDR r0, =0x13
	LDR r1, =0xffffffff
	LDR r2, =0xeeeeeeee
	LDR r3, =0x800c

	LDMIA r3!, {r0,r1,r2}

	STMFA r13!, {r0-r5}
	LDMFA r13!, {r0-r5}


	LDR r0, =0xbabe2222
	LDR r1, =0x12340000
	LDR r13, =0x800c

	STMFA r13!, {r0}
	STMFA r13!, {r1}
	LDMFA r13!, {r0, r1}


	swi 0x0
	
