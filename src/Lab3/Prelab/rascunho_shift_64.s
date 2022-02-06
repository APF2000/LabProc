	.text
	.globl	main
main:
	@ Shift de 1 para a direita
	ldr r0, =0xaaaa0000
	ldr r1, =0xaaaa0000
	movs r0, r0, rrx @ Gira junto com o carry: rotate 33 bits
	movs r0, r0, rrx
	movs r0, r0, rrx
	movs r0, r0, rrx
        
	mov r0, r0, rrx
        mov r0, r0, rrx
        mov r0, r0, rrx
        mov r0, r0, rrx
        mov r0, r0, rrx


        @ Shift de 1 para a direita
        ldr r0, =0xaaaa0000
        ldr r1, =0xaaaa0000
        mov r0, r0, rrx @ Gira junto com o carry: rotate 33 bits

	swi 0x0
	
