#include <stdint.h>
 
#define UART0_BASE_ADDR 0x101f1000
#define UART0_DR (*((volatile uint32_t *)(UART0_BASE_ADDR + 0x000)))
#define UART0_IMSC (*((volatile uint32_t *)(UART0_BASE_ADDR + 0x038)))

volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;

#define VIC_BASE_ADDR 0x10140000
#define VIC_INTENABLE (*((volatile uint32_t *)(VIC_BASE_ADDR + 0x010)))

#define LAST_STATE 6

void print_uart0(const char *s) {
	while(*s != '\0') { /* Loop until end of string */
 		*UART0DR = (unsigned int)(*s); /* Transmit char */
		s++; /* Next char */
 	}
}

//const char teste = '@';
static uint32_t can_print = 1;
static uint32_t state = 0; // identificar padrao ROSEBUD
//static uint32_t letter;

void prox_passo(int target)
{
	if(state == LAST_STATE) can_print = 0;


	if(state == target){
		 (state)++;
		 print_uart0("deu bom + 1");
	}
	else (state) = 0;
}

void __attribute__((interrupt)) irq_handler(){//const char *s) {
 /* echo the received character + 1 */

 //UART0_DR = UART0_DR;
 	char c = UART0_DR;
	char st[2];
	st[0] = c;
	st[1] = '\0';
	print_uart0(st);
 /*__asm__( 
		"ldr r1, =mostra\n"
		"mov r2, #123\n"
		"str r2, [r1]\n"
);*/

 //letter = (uint32_t)((uint8_t volatile *) UART0_DR);
 switch(c)
 {
	 case 0x72: // letra r em hexadecimal ascii
	 	prox_passo(0);
		break;
	 case 0x6f: // letra o em hexadecimal ascii
	 	prox_passo(1);
		break;
	 case 0x73: // letra s em hexadecimal ascii
	 	prox_passo(2);
		break;
	 case 0x65: // letra e em hexadecimal ascii
	 	prox_passo(3);
		break;
	 case 0x62: // letra b em hexadecimal ascii
	 	prox_passo(4);
		break;
	 case 0x75: // letra u em hexadecimal ascii
	 	prox_passo(5);
		break;
	 case 0x64: // letra d em hexadecimal ascii
	 	prox_passo(6);
		break;
	 default: 
	 	state = 0; // reseta a maquina de estados
		can_print = 1;
		return;
 }
}

int counter = 0;
void /*__attribute__((interrupt))*/ print_interrupcao() {
 /* echo the received character + 1 */
 
 if(can_print){
	print_uart0("#");
 }
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