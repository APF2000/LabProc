// Experiencia 10
// Arthur píres da Fonseca
// Para rodar use eabi-as irq.s -o irq.o && eabi-as handler.s -o startup.o && eabi-gcc handler.c -o handler.o && eabi-ld -T irqld.ld irq.o startup.o handler.o -o irq.elf && eabi-bin irq.elf irq.bin && qemu irq.bin

volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
 
void print_uart0(const char *s) {
	while(*s != '\0') { /* Loop until end of string */
 		*UART0DR = (unsigned int)(*s); /* Transmit char */
		s++; /* Next char */
 	}
}

void print_interrupcao()
{
	print_uart0("#");
}

void print_loop()
{
	print_uart0(" ");	
}
