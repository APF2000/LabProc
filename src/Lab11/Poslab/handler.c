volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
 
void print_uart0(const char *s) {
 while(*s != '\0') { /* Loop until end of string */
 *UART0DR = (unsigned int)(*s); /* Transmit char */
 s++; /* Next char */
 }
}
 
void first_process() {
 print_uart0("Arthur Pires da Fonseca");
}

void second_process(){
 print_uart0("10773096");
}

void print_hash(){
 print_uart0("#");
}

