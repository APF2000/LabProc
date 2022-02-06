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
 stack_top_b = .;
 . = . + 0x1000; /* 4kB of stack memory */
 stack_top_a = .;
 . = . + 0x1000; /* 4kB of stack memory */
 timer_stack_top = .;
}
