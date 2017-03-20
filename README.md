# arm_clang_cpp_example

An example of booting an ARM processor to C++, compiled with Clang.  This example shows:

* Building a ARM cross-compile toolchain using GNU BinUtils and Clang
* Booting the ARM chip, and running C++ code
* Custom crt0 which initializes and deinitializes static data
* C++ class instances allocated on the heap 
* C++ global class instances
* Zero-ing the .bss
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
new: 74080 size: 1
Kernel::ctor
Kernel::run
__startup_begin: 65536
__text_begin: 65552
__bss_begin: 68568
__data_begin: 69600
__rodata_begin: 69604
__init_array_begin: 69972
__fini_array_begin: 69976
__stack_top: 74080
__stack_size: 4096
__heap_bottom: 74080
__heap_size: 65536
new: 74180 size: 4
Obj1 int ctor with value: 77
77
Obj1 dtor with value: 77
delete: 74180
12
Kernel::dtor
delete: 74080
Obj1 dtor with value: 12
crt.c _fini
QEMU: Terminated
</pre>
