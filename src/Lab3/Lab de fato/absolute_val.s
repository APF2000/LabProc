@ Exercicio 3.10.6 (apostila) : absolute value
@ Para debugar este codigo:
@ gcc absolute_val.s && gdb a.out 
.text
	.globl main
main:
	MOV r0, #-2
    	MOV r1, #0
    	CMP r0, #0
	BLE	absolutevalue  			
	SWI	0x123456		
absolutevalue:
	SUB     r0, r1, r0
	MOV	    pc, lr
