	/*  */	
	/* 	Arthur Pires da Fonseca, NUSP: 10773096 */	
	/* 	Para rodar os arquivos do exercício X:  */	
	/* 	eabi-gcc test.c -o test.o  */	
	/* 	eabi-as startup.s -o startup.o  */	
	/* 	eabi-ld -T vector_table.ld test.o startup.o -o program.elf  */	
	/* 	eabi-bin program.elf program.bin  */	
	/* 	qemu program.bin */	
	/* 	 */	
int c_entry() {
  return 0;
}
