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
 svc_stack_top = .;
 . = . + 0x1000; /* 4kB of stack memory */
 irq_stack_top = .;
}
