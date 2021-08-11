#include <stdint.h>
 
#define UART0_BASE_ADDR 0x101f1000
#define UART0_DR (*((volatile uint32_t *)(UART0_BASE_ADDR + 0x000)))
#define UART0_IMSC (*((volatile uint32_t *)(UART0_BASE_ADDR + 0x038)))

volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;

#define VIC_BASE_ADDR 0x10140000
#define VIC_INTENABLE (*((volatile uint32_t *)(VIC_BASE_ADDR + 0x010)))


void __attribute__((interrupt)) irq_handler() {
 /* echo the received character + 1 */
 UART0_DR = UART0_DR;
}

void print_uart0(const char *s) {
	while(*s != '\0') { /* Loop until end of string */
 		*UART0DR = (unsigned int)(*s); /* Transmit char */
		s++; /* Next char */
 	}
}

int counter = 0;
void /*__attribute__((interrupt))*/ print_interrupcao() {
 /* echo the received character + 1 */
 counter = (counter + 1) % 1000001;
 //if(counter >= 1000000)
 //{
	print_uart0("#");
 //}
}


/* all other handlers are infinite loops */
void __attribute__((interrupt)) undef_handler(void) { for(;;); }
void __attribute__((interrupt)) swi_handler(void) { for(;;); }
void __attribute__((interrupt)) prefetch_abort_handler(void) { for(;;); }
void __attribute__((interrupt)) data_abort_handler(void) { for(;;); }
void __attribute__((interrupt)) fiq_handler(void) { for(;;); }
 
void copy_vectors(void) {
 extern uint32_t vectors_start;
 extern uint32_t vectors_end;
 uint32_t *vectors_src = &vectors_start;
 uint32_t *vectors_dst = (uint32_t *)0;
 
while(vectors_src < &vectors_end)
 *vectors_dst++ = *vectors_src++;
}
 
int main(void) {
 /* enable UART0 IRQ */
 VIC_INTENABLE = 1<<12;
 /* enable RXIM interrupt */
 UART0_IMSC = 1<<4;
 //timer_init();
 for(;;);
}