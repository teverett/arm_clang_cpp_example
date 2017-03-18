

all	: main.elf

TOOLCHAIN=~tom/projects/build_clang_crosscompiler/binary

#tools
CXX=$(TOOLCHAIN)/bin/clang++
LD=$(TOOLCHAIN)/arm-none-elf/bin/arm-none-elf-ld
OBJDUMP=$(TOOLCHAIN)/arm-none-elf/bin/arm-none-elf-objdump	
AS=$(TOOLCHAIN)/arm-none-elf/bin/arm-none-elf-as

#flags
CPP_FLAGS=-v --target=arm-none-elf -S 

asm/main.s: src/main.cpp
	$(CXX) $(CPP_FLAGS) src/main.cpp -o asm/main.s

obj/main.o: asm/main.s
	$(AS) -o obj/main.o asm/main.s

asm/obj1.s: src/obj1.cpp
	$(CXX) $(CPP_FLAGS) src/obj1.cpp -o asm/obj1.s

obj/obj1.o: asm/obj1.s
	$(AS) -o obj/obj1.o asm/obj1.s

obj/startup.o: src/startup.s
	$(AS) -o obj/startup.o src/startup.s

main.elf: dirs obj/main.o obj/obj1.o obj/startup.o dump
	$(LD) obj/main.o obj/obj1.o obj/startup.o -o main.elf -T src/clang_cpp_example.ld

dump: dirs obj/main.o obj/obj1.o obj/startup.o
	$(OBJDUMP) -h obj/main.o
	$(OBJDUMP) -h obj/obj1.o
	$(OBJDUMP) -h obj/startup.o

dirs:
	mkdir -p asm
	mkdir -p obj

clean:
	rm -rf asm
	rm -rf obj
