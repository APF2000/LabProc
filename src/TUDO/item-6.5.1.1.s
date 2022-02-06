    .text
    .globl    main
main:   
        LDR	r1, =0x123
        LDR	r2, =0x124
        LDR	r4, =0x01
        BL	func1
        B	out

func1:        
        MLA    r0, r1, r2, r4
        BX    lr

out:
        SWI 0x123456
        