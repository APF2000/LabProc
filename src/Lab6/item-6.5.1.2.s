    .text
    .globl    main
main:		
	LDR		r1, =0x01
	LDR		r2, =0x06
	LDR		r4, =0x0f
	STRB 	r1, b
	STRB	r2, c
	STRB	r4, d    
	BL		func1
	B		out

func1:		
	LDRB	r6, b
	LDRB	r7, c
	LDRB	r8, d
	MLA		r0, r6, r7, r8
	STR		r0, a
	BX		lr

out:
    SWI 	0x123456

a: 
	.byte 0x00
b:
	.byte 0x00
c:
	.byte 0x00
d:
	.byte 0x00

