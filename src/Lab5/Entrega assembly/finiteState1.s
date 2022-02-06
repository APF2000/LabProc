	.text
	.globl main

main:
    MOV r8, #0x5        @ = 0101
    MOV r9, #0x4        @ Tamanho
    LDR r1, =0xAAAA5555    @ = 10101010101010100101010101010101
    MOV r2, #0x0        @ 0 inicial, espera-se 00001010101010100001010101010101 ou AAA1555 na saída
    MOV r3, r1        

begin:
    MOV r5, #0x1        @ r5 = vetor de adicao
    MOV r6, #32        @ r6 = 32 
    SUB r6, r6, r9    @ r6 = 32 - r9
    MOV r7, #0x1        @ r7 = contador 
    MOV r2, #0x0        @ r2 = resultado
    MOV r5, r5, ROR r9    @ Rotaciona r5 pelo tamanho de Y

loop:
    MOV r4, r3, LSR r6    @ Shifta r3 por r6 vezes e guarda em r4
    CMP r4, r8        @ Compara r4 com r8
    ADDEQ r2, r2, r5    @ Se r4 e r8 iguais, r5 + r2
    ADD r7, r7, #1    @ r7++
    MOV r5, r5, ROR #1    @ Rotaciona o vetor de adicao 
    MOV r3, r3, LSL #1    @ Shifta X 
    CMP r7, #32        @ Compara r7 e 32 
    BLS loop        @ Se r7 maior que 32, itera de novo

end:
    SWI 0x12345
