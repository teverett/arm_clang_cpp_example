![CI](https://github.com/teverett/arm_clang_cpp_example/workflows/CI/badge.svg)

# arm_clang_cpp_example

An example of creating a custom ARM toolchain based on Clang and booting an ARM processor to C++.  This example shows:

* Building a ARM cross-compile toolchain using GNU BinUtils and Clang
* Booting the ARM chip, and running C++ code
* Custom crt0 which initializes and de-initializes static data
* C++ class instances allocated on the heap 
* C++ global class instances
* Zero-ing the .bss and heap
* GNU LD link script

## Toolchain

This example uses the toolchain built by 

* [GNU Binutils](https://www.gnu.org/software/binutils/) - 2.34
* [GNU Make](https://www.gnu.org/software/make/) - 3.82
* [CMake](https://cmake.org/) - 3.17.2
* [Clang](https://clang.llvm.org/) - 10.0.0

To build the toolchain

<pre>
cd toolchain
sh build_toolchain.sh
</pre>

### The toolchain supports these targets:

* arm-none-eabi 
* arm-none-elf 
* mips-none-elf 
* mipsel-none-elf 
* mips64-none-elf 
* mips64el-none-elf 
* sparc-none-elf 
* avr-none-elf

## Building the example

The provided MakeFile supports assembler, C, C++ and ObjectiveC source and targets the arm-none-elf platform

<pre>
make
</pre>

## Running the example

<pre>
make run
</pre>

This requires that your system have `qemu-system-arm` installed

### Example Output

<pre>
qemu-system-arm  -M versatilepb -m 128M -nographic -kernel kernel.bin
crt.c _init
Obj1 int ctor with value: 12
Hello from Clang
new: 74168 size: 1
Kernel::ctor
Kernel::run
__startup_begin: 65536
__text_begin: 65552
__bss_begin: 68656
__data_begin: 69688
__rodata_begin: 69692
__init_array_begin: 70060
__fini_array_begin: 70064
__stack_top: 74168
__stack_size: 4096
__heap_bottom: 74168
__heap_size: 65536
new: 74268 size: 4
Obj1 int ctor with value: 77
77
Obj1 dtor with value: 77
delete: 74268
12
Kernel::dtor
delete: 74168
Obj1 dtor with value: 12
crt.c _fini
QEMU: Terminated
</pre>
