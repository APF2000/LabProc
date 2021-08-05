#!/bin/sh

arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g script.c -o script.o 
arm-none-eabi-as -c -mcpu=arm926ej-s -g startup.s -o startup.o
arm-none-eabi-ld -T t.ld startup.o script.o -o irq.elf
arm-none-eabi-objcopy -O binary irq.elf irq.bin
qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel irq.bin
