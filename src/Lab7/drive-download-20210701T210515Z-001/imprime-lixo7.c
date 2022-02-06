void imprime(int N){
    int lixo;
    if (N<1){
        return;
    }
    printf("numero = %d\n", N);
    lixo++;
    imprime(N-1);
}

int main(void){
    
    imprime(7);
}


