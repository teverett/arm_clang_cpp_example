# arm_clang_cpp_example

An example of booting an ARM processor to C++, compiled with Clang.  

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
new: 73792 size: 1
Kernel::ctor
Kernel::run
__startup_begin: 65536
__text_begin: 65552
__data_begin: 68652
__bss_begin: 68656
__init_array_begin: 69688
__fini_array_begin: 69692
__stack_top: 73792
__stack_size: 4096
__heap_bottom: 73792
__heap_size: 65536
new: 73892 size: 4
Obj1 int ctor with value: 77
77
Obj1 dtor with value: 77
delete: 73892
Kernel::dtor
delete: 73792
Obj1 dtor with value: 12
crt.c _fini
QEMU: Terminated
</pre>
