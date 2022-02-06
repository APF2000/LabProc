	.text
	.globl main

main:
    MOV r8, #0x5	    @ padrao procurado
    MOV r9, #0x3            @ Tamanho do padrao
    LDR r1, =0x5555AAAA     @ palavra onde será feita a busca
    MOV r2, #0x0            @ registrador resultado
    MOV r3, r1              @ auxiliar da palavra

begin:
    MOV r5, #0x1            @ r5 flag de match
    MOV r6, #32             @ r6 shift maximo da flag de match
    SUB r6, r6, r9          @ r6 recebe 32 menos o tamanho do padrao
    MOV r7, #0x1            @ r7 = contador 
    MOV r5, r5, ROR r9      @ Rotaciona flag de match pelo tamanho de Y -> equivalente a shiftar para alinhar o padrao ao comeco da palavra

loop:
    MOV r4, r3, LSR r6      @ Guarda em r4 o pedaço da palavra a ser comparado
    
    CMP r4, r8              @ Compara r4 com r8 (pedaço da palavra com padrao)
    ADDEQ r2, r2, r5        @ Se o padrão corresponder ao pedaço, adiciona adiciona flag de match ao resultado
    MOV r5, r5, ROR #1      @ Rotaciona a flag de match em 1 bit p direita
    MOV r3, r3, LSL #1      @ Shifta palavra em 1 bit pra esquerda
    
    ADD r7, r7, #1          @ contador++
    CMP r7, #32             @ Compara contador e 32 
    BLS loop                @ Se contador maior que 32, itera de novo

end:
    SWI 0x12345
