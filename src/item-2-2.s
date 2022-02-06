	.text
	.globl	main
main:
	LDR r0, =0xffff0000 @MOV	r0, #15
	LDR r1, =0x87654321 @MOV	r1, #20
	BL	firstfunc
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
firstfunc:
	ADDS	r0, r0, r1
	
	MOV	pc, lr


