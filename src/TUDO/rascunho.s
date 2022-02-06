	.text
	.globl	main
main:
	ldr r0, =0x1
	mov r1, r0, lsl #7
	mov r2, r0, lsl #2
	add r0, r1, r2

        ldr r0, =0x1
        mov r1, r0, lsl #2
        add r0, r1, r0, lsl #7

	swi 0x0
	
