#arm-none-eabi-gcc -mcpu=arm926ej-s -c -o test.o test.c
#arm-none-eabi-gcc -mcpu=arm926ej-s -c -o vectors.o vectors.S
#arm-none-eabi-gcc --gc-sections -T test.ld test.o vectors.o -o test
#arm-none-eabi-objcopy -O binary test test.bin
#qemu-system-arm -M versatilepb -serial stdio -kernel test.bin
#qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel test.bin--gc-sections

