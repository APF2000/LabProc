@ Exercicio 3.10.5 da apostila
@ Para debugar este codigo:
@ gcc mult_signed.s && gdb a.out
    .text
    .globl    main
main:
    ldr r0, =2
    ldr r1, =4
    ldr r5, =1    @ fator para o resultado final
    ldr r6, =0
    
    CMP r0, #0
    SUBLT r5, r6, r5, lsl #0
    CMP r1, #0
    SUBLT r5, r6, r5, lsl #0
    
    MOV r2, #0
    ADD r2, r1, r1, ASR #31
    EOR r1, r2, r1, ASR #31
    
    ADD r2, r0, r0, ASR #31
    EOR r0, r2, r0, ASR #31
    
    MUL r3, r0, r1
    MUL r3, r5, r3
    
    swi 0x0
