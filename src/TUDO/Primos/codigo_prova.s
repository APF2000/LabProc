	.text
	.globl	main
main:

	LDR r3, =0x8000
	@STR r6, [r3, #12]
	@STRB r7, [r3], #4
	@LDRH r5, [r3], #8
	LDR r12, [r3, #12]!

@1) codigo1:

ex1:  	LDR    r3, =0x7B000000
        LDR    r4, =0x30000000
q1:    	ADDS r5, r4, r3

@2) codigo2:

	LDR r3, =0x8000
	LDR r6, =0xBEEFFACE

ex2: 	STR   r6, [r3]
q2:   	LDRB  r4, [r3]

fim:
	swi 0x0
