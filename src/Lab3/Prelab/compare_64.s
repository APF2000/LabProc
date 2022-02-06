	.text
	.globl	main
main:
	@ 0xfedcba98_12345678 == 0x89abcdef_12345678 ??
	ldr r0, =0xfedcba98
	ldr r1, =0x12345678
	ldr r2, =0xfedcba98
	ldr r3, =0x12345678
	ldr r7, =0x1

	subs r5, r3, r1 @ Compara bits menos significativos
	subeqs r4, r2, r0 @ Compara bit mais significativos 
	@subeq r7, r7, r7 @ Se r7 for zero é pq os números são iguais

        @ 0xfedcba98_12345678 == 0x89abcdef_12345677 ??
        ldr r0, =0xfedcba98
        ldr r1, =0x12345678
        ldr r2, =0x89abcdef
        ldr r3, =0x12345677
	ldr r7, =0x1

        subs r5, r3, r1 @ Compara bits menos significativos
        subeq r4, r2, r0 @ Compara bit mais significativos 
	@subeq r7, r7, r7 @ Se for zero depois disso, os n�meros são iguais

	swi 0x0
	
