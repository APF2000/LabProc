#include <stdio.h>
#include <stdlib.h>				
extern void int2str(int inteiro, char *pontstr);

int main()
{
	int num = 0x12344321;
	char *st = malloc(5*sizeof(char));
	int2str(num, st);
	puts(st);
	printf("%s\n", st);
	return 0;
	
}
	/*				
int main()
{
	int a = 4;
	int b = 5;
	printf("Adding %d and %d results in %d\n", a, b, myadd(a, b));
	return (0);
}*/
