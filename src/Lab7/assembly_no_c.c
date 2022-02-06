#include <stdio.h>

int mostra;
					
int main()
{
	//mostra = 1234;

	
	__asm__( 
		"ldr r1, =mostra\n"
		"mov r2, #123\n"
		"str r2, [r1]\n"
	);

	return (0);
}
