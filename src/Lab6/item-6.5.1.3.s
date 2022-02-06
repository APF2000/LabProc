    .text
    .globl    main

main:		
	LDR		r1, =0x01
    LDR		r2, =0x06
	LDR		r4, =0x0f
	BL		func1
	B		out

func1:		
	LDR		sp, =a
	STMEA   sp!, {r1, r2, r4, lr}
	LDMEA	sp!, {r1-r3, r5}
	MLA		r4, r1, r2, r3
	BL		func2
	LDMEA	sp!, {r1, lr}
	BX		lr
       
func2:		

	STMEA	sp!, {r4, r5}
    BX		lr

out:
    SWI 	0x123456

a:    .word 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
