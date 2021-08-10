#!/bin/sh

arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g test.c -o test.o 

arm-none-eabi-as -c -mcpu=arm926ej-s -g vectors.s -o vectors.o

arm-none-eabi-ld -T test.ld test.o vectors.o -o test.elf
arm-none-eabi-objcopy -O binary test.elf test.bin
qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel test.bin
#qemu-system-arm -M versatilepb -serial stdio -kernel test.bin
