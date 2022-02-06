#include <stdio.h>
#include <string.h>
#include <stdlib.h>	

extern void int2str(int nusp, char  pontstr[]);

void imprime(int N){
    if (N<0){
        return;
    }
    // char ptr[6];
    char *ptr = malloc(6*sizeof(char));
    int2str(N, ptr);
    puts(ptr);
    imprime(N-1);
}

int main(void){
    imprime(5);
    return 0;
}
