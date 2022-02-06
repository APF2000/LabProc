    .text
    .globl main

main:
    ADR     r2, dados       @ carrega array de inteiros em r2
    MOV     r5, #13         @ salva tamanho em r5
    SUB     r5, r5, #1      @ pega valor do ultimo indice com tamanho -1
    MOV     r7, r2          @ guarga endereço em r7
    LDR     r1, [r7], #4    @ r1 salva o maior elemento, e inicia com o primeiro
    MOV     r0, #0          @ contador começa em 0
loop:
    CMP     r0, r5          @ compara contador com valor do ultimo indice
    BGE     end             @ se maior, sai
    LDR     r4, [r7], #4    @ pega o próximo elemento de r7 e guarga em r4
    CMP     r1, r4          @ compara r1 com r4
    MOVLT   r1, r4          @ se for menor, armazena r4 em r1
    ADD     r0, r0, #1      @ incrmenta contador
    B       loop            
end:
    STR     r1, [r7]
    SWI     0x12345
dados:
    .word 1, 30, 2, 5, 19, 21, 25, 29, 4, 20, 32, 6, 35
