# arm_clang_cpp_example

An example of booting an ARM processor to C++, compiled with Clang.  This example shows:

* Building a ARM cross-compile toolchain using GNU BinUtils and Clang
* Booting the ARM chip, and running C++ code
* Custom crt0 which initializes and deinitializes static data
* C++ class instances allocated on the heap 
* C++ global class instances
* GNU LD link script

## Toolchain

This example uses the toolchain built by 

* GNU Binutils - 2.28
* GNU Make - 3.82
* CMake - 3.7.2
* Clang - 4.0.0

To build the toolchain

<pre>
cd toolchain
sh build_toolchain.sh
</pre>

## Building the example

`make`

### Example Output

<pre>
qemu-system-arm  -M versatilepb -m 128M -nographic -kernel kernel.bin
crt.c _init
Obj1 int ctor with value: 12
Hello from Clang
new: 73840 size: 1
Kernel::ctor
Kernel::run
__startup_begin: 65536
__text_begin: 65552
__bss_begin: 68332
__data_begin: 69364
__rodata_begin: 69368
__init_array_begin: 69732
__fini_array_begin: 69736
__stack_top: 73840
__stack_size: 4096
__heap_bottom: 73840
__heap_size: 65536
new: 73940 size: 4
Obj1 int ctor with value: 77
77
Obj1 dtor with value: 77
delete: 73940
Kernel::dtor
delete: 73840
Obj1 dtor with value: 12
crt.c _fini
QEMU: Terminated
</pre>
