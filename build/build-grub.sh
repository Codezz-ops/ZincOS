mkdir obj
mkdir -p isodir/boot/grub
i686-elf-as boot/boot.s -o obj/boot.o
i686-elf-gcc -c kernel/kernel.c -o obj/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T linker/linker.ld -o zincOS.bin -ffreestanding -O2 -nostdlib obj/boot.o obj/kernel.o 
cp zincOS.bin isodir/boot/zincOS.bin
cp boot/grub.cfg isodir/boot/grub/grub.cfg
grub-file --is-x86-multiboot zincOS.bin
grub-mkrescue -o zincOS.iso isodir
qemu-system-i386 -cdrom zincOS.iso
