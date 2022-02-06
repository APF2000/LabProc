@ Experiencia 10
@ Arthur píres da Fonseca
@ Para rodar use eabi-as irq.s -o irq.o && eabi-as handler.s -o startup.o && eabi-gcc handler.c -o handler.o && eabi-ld -T irqld.ld irq.o startup.o handler.o -o irq.elf && eabi-bin irq.elf irq.bin && qemu irq.bin

.global handler_timer
.text
@TIMER0X: .word 0x101E200c @timer 0 interrupt clear register
handler_timer:
  BL print_interrupcao
  mov  pc, lr @retorna
