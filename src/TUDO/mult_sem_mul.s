	.text
	.globl	main
main:
	
	@@@@@ mul r0, r0, #132 @@@@@
        ldr r0, =0xa
        mov r1, r0, lsl #2
        add r0, r1, r0, lsl #7

        @@@@@ mul r0, r0, #255 @@@@@
        ldr r0, =0xa
        mov r1, r0, lsl #8
        sub r0, r1, r0

        @@@@@ mul r0, r0, #18 @@@@@
        ldr r0, =0xa
        mov r1, r0, lsl #4
        add r0, r1, r0, lsl #1

        @@@@@ mul r0, r0 #16384 @@@@@
        ldr r0, =0xa
        mov r0, r0, lsl #14	

	swi 0x0
	
