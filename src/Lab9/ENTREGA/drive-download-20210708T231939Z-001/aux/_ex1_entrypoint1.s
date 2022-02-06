	/*  */	
	/* 	Arthur Pires da Fonseca, NUSP: 10773096 */	
	/* 	Para rodar os arquivos do exercício X:  */	
	/* 	eabi-gcc test.c -o test.o  */	
	/* 	eabi-as startup.s -o startup.o  */	
	/* 	eabi-ld -T vector_table.ld test.o startup.o -o program.elf  */	
	/* 	eabi-bin program.elf program.bin  */	
	/* 	qemu program.bin */	
	/* 	 */	
	.file	"entrypoint.c"
	.text
	.align	2
	.global	c_entry
	.type	c_entry, %function
c_entry:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp, {fp, sp, pc}
	.size	c_entry, .-c_entry
	.ident	"GCC: (GNU) 3.4.3"
