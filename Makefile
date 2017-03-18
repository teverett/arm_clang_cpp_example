

all	: kernel.bin

TARGET=arm-none-eabi

TOOLS_DIR=~tom/projects/build_clang_crosscompiler/binary

# dirs
SRC_ROOT=src
ASM=asm
OBJ_DIR=obj

#args
ASARGS=
CCARGS=-target $(TARGET)
CCPARGS=-target $(TARGET) -v -S -fno-rtti -fno-exceptions  -fno-use-cxa-atexit

#tools
CC=$(TOOLS_DIR)/bin/clang
CPP=$(TOOLS_DIR)/bin/clang++
AS=$(TOOLS_DIR)/$(TARGET)/$(TARGET)/bin/as
LD=$(TOOLS_DIR)/$(TARGET)/$(TARGET)/bin/ld
OBJCOPY=$(TOOLS_DIR)/$(TARGET)/$(TARGET)/bin/objcopy
OBJDUMP=$(TOOLS_DIR)/$(TARGET)/$(TARGET)/bin/objdump
QEMU=qemu-system-arm 

# sources
SRCS_ASM=$(shell find $(SRC_ROOT) -type f -iname '*.s')
SRCS_OBJC=$(shell find $(SRC_ROOT) -type f -iname '*.m')
SRCS_C=$(shell find $(SRC_ROOT) -type f -iname '*.c')
SRCS_CPP=$(shell find $(SRC_ROOT) -type f -iname '*.cpp')

# all sources
SRCS=$(SRCS_ASM)$(SRCS_OBJC)$(SRCS_C)$(SRCS_CPP)

# obj dirs
OBJS_ASM=$(subst $(SRC_ROOT)/, , $(SRCS_ASM:.s=.o))
OBJS_OBJC=$(subst $(SRC_ROOT)/, , $(SRCS_OBJC:.m=.o))
OBJS_C=$(subst $(SRC_ROOT)/, , $(SRCS_C:.c=.o))
OBJS_CPP=$(subst $(SRC_ROOT)/, , $(SRCS_CPP:.cpp=.o))

# object files
OBJS=$(addprefix $(OBJ_DIR)/, $(OBJS_ASM) $(OBJS_OBJC) $(OBJS_C) $(OBJS_CPP))

# set search paths
vpath %.m $(SRC_ROOT)/
vpath %.s $(SRC_ROOT)/
vpath %.c $(SRC_ROOT)/
vpath %.cpp $(SRC_ROOT)/

# objc files	
$(OBJ_DIR)/%.o: %.m
	mkdir -p $(@D)
	$(CPP) $(CCPARGS) -S -c -o $(ASM)/$(notdir $<).asm $<
	$(AS) $(ASARGS) -o $@ $(ASM)/$(notdir $<).asm 

# s files
$(OBJ_DIR)/%.o: %.s
	mkdir -p $(@D)
	$(AS) $(ASARGS) -o $@ $< 

# c files
$(OBJ_DIR)/%.o: %.c
	mkdir -p $(@D)
	$(CC) $(CCARGS) -S -c -o $(ASM)/$(notdir $<).asm $<
	$(AS) $(ASARGS) -o $@ $(ASM)/$(notdir $<).asm 

# cpp files
$(OBJ_DIR)/%.o: %.cpp
	mkdir -p $(@D)
	$(CPP) $(CCPARGS) -S -c -o $(ASM)/$(notdir $<).asm $<
	$(AS) $(ASARGS) -o $@ $(ASM)/$(notdir $<).asm 

run: kernel.bin
	$(QEMU) -M versatilepb -m 128M -nographic -kernel kernel.bin

kernel.bin: $(OBJ_DIR)/kernel.elf dump
	$(OBJCOPY) -O binary $(OBJ_DIR)/kernel.elf kernel.bin

# elf kernel
$(OBJ_DIR)/kernel.elf: dirs $(OBJS)
	$(LD) $(OBJS) -o $(OBJ_DIR)/kernel.elf -T $(SRC_ROOT)/kernel.ld

dump: $(OBJ_DIR)/kernel.elf
	$(OBJDUMP) -h $(OBJS)
	$(OBJDUMP) -h $(OBJ_DIR)/kernel.elf

dirs:
	mkdir -p $(ASM)

clean:
	rm -rf $(ASM)
	rm -rf $(OBJ_DIR)
	rm -f *.bin
