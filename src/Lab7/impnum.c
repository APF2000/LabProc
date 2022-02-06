#include <stdio.h>
					
extern void int2str(int inteiro, char *pontstr);

void impnum(int num)
{
	char *st;
	int2str(num, st);
	puts(st);
	//printf("%s\n", st);
}
					
int main()
{
	int a = 4;
	int b = 5;
	printf("Adding %d and %d results in %d\n", a, b, myadd(a, b));
	return (0);
}
