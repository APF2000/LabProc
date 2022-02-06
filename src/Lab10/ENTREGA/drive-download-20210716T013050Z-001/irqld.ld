/* Experiencia 10 */
/* Arthur píres da Fonseca */
/* Para rodar use eabi-as irq.s -o irq.o && eabi-as handler.s -o startup.o && eabi-gcc handler.c -o handler.o && eabi-ld -T irqld.ld irq.o startup.o handler.o -o irq.elf && eabi-bin irq.elf irq.bin && qemu irq.bin */

ENTRY(_start)
SECTIONS
{
 . = 0x0;
 .text : {
 startup.o (INTERRUPT_VECTOR)
 *(.text)
 }
 .data : { *(.data) }
 .bss : { *(.bss) }
 . = . + 0x1000; /* 4kB of stack memory */
 stack_top = .;
 . = . + 0x1000; /* 4kB of stack memory */
 timer_stack_top = .;
}
