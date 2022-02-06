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

void print_task_a()
{
	print_uart0("123456789");//Arthur Pires da Fonseca");	
}

void print_task_b()
{
	print_uart0("abcdefghi");//10773096");	
}
