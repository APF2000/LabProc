#!/bin/sh

gdb-multiarch -tui --command=/home/arthur/Documents/Poli/LabProc/gcc-arm/docker/files/.gdbinit/qemu -se irq.elf
