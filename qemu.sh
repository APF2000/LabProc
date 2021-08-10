#!/bin/sh

arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g script.c -o script.o 
arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g kbd.c -o kbd.o 
arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g string.c -o string.o 
arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g vid.c -o vid.o 
arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g timer.c -o timer.o 
arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g keymap.c -o keymap.o 

arm-none-eabi-as -c -mcpu=arm926ej-s -g startup.s -o startup.o
arm-none-eabi-as -c -mcpu=arm926ej-s -g ts.s -o ts.o

arm-none-eabi-ld -T t.ld startup.o ts.o script.o kbd.o string.o vid.o timer.o keymap.o -o irq.elf
arm-none-eabi-objcopy -O binary irq.elf irq.bin
qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel irq.bin
