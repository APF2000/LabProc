    .text
    .globl main
    
main:
    LDR     r0, =0          @ contador inicia em 0
    LDR     r1, =0x4000     @ r1 - array a
    LDR     r2, =0x5000     @ r2 - array b

loop:
    CMP     r0, #7          @ compara r0 com 7
    BHI     fim             @ se for maior, acaba o loop
    RSB     r3, r0, #7      @ r3 = 7 - i
    LDRB    r4, [r1, r3]    @ carrega b[r3] ou seja b[7-1]
    STRB    r4, [r2, r0]    @ armazena em a[r0] ou seja a[i]
    ADD     r0, r0, #1      @ incrementa r0
    BAL     loop

fim:
    SWI     0x12345
