

all	: main.bin

TOOLCHAIN=~tom/projects/build_clang_crosscompiler/binary

#tools
CXX=$(TOOLCHAIN)/bin/clang++
LD=$(TOOLCHAIN)/arm-none-elf/bin/arm-none-elf-ld
AS=$(TOOLCHAIN)/arm-none-elf/bin/arm-none-elf-as
OBJCOPY=$(TOOLCHAIN)/arm-none-elf/bin/arm-none-elf-objcopy
OBJDUMP=$(TOOLCHAIN)/arm-none-elf/bin/arm-none-elf-objdump
QEMU=qemu-system-arm 	

#flags
CXX_FLAGS=-v --target=arm-none-elf -S -fno-rtti -fno-exceptions

asm/main.s: src/main.cpp
	$(CXX) $(CXX_FLAGS) src/main.cpp -o asm/main.s

obj/main.o: asm/main.s
	$(AS) -o obj/main.o asm/main.s

asm/obj1.s: src/obj1.cpp
	$(CXX) $(CXX_FLAGS) src/obj1.cpp -o asm/obj1.s

obj/obj1.o: asm/obj1.s
	$(AS) -o obj/obj1.o asm/obj1.s

asm/newdel.s: src/newdel.cpp
	$(CXX) $(CXX_FLAGS) src/newdel.cpp -o asm/newdel.s

obj/newdel.o: asm/newdel.s
	$(AS) -o obj/newdel.o asm/newdel.s

asm/serial.s: src/serial.cpp
	$(CXX) $(CXX_FLAGS) src/serial.cpp -o asm/serial.s

obj/serial.o: asm/serial.s
	$(AS) -o obj/serial.o asm/serial.s

obj/startup.o: src/startup.s
	$(AS) -o obj/startup.o src/startup.s

run: main.bin
	$(QEMU) -M versatilepb -m 128M -nographic -kernel main.bin

main.bin: main.elf
	$(OBJCOPY) -O binary main.elf main.bin

main.elf: dirs obj/main.o obj/obj1.o obj/startup.o obj/newdel.o obj/serial.o dump
	$(LD) obj/main.o obj/obj1.o obj/startup.o obj/newdel.o obj/serial.o -o main.elf -T src/clang_cpp_example.ld
	$(OBJDUMP) -h main.elf

dump: dirs obj/main.o obj/obj1.o obj/startup.o
	$(OBJDUMP) -h obj/main.o
	$(OBJDUMP) -h obj/obj1.o
	$(OBJDUMP) -h obj/newdel.o
	$(OBJDUMP) -h obj/serial.o
	$(OBJDUMP) -h obj/startup.o

dirs:
	mkdir -p asm
	mkdir -p obj

clean:
	rm -rf asm
	rm -rf obj
