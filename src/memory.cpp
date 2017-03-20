extern "C" {
#include "serial.h"
#include "image.h"
}

#include "allocator.hpp"

/*
* static allocator
*/
static Allocator allocator(&__heap_bottom);

/*
 * custom new and delete operators needed by C++
 */
void* operator new(unsigned int count) {
	print_uart0_str("new: ");
	void* block = (void*) allocator.allocate(count);
	print_uart0_int((unsigned int) block);
	print_uart0_str(" size: ");
	print_uart0_int((unsigned int) count);
	print_uart0_str("\n");
	return block;
}

void operator delete(void* ptr) {
	allocator.free((unsigned int*)ptr);
	print_uart0_str("delete: ");
	print_uart0_int((unsigned int) ptr);
	print_uart0_str("\n");
}

void* operator new[](unsigned int count) {
	print_uart0_str("new[]: ");
	void* block = (void*) allocator.allocate(count);
	print_uart0_int((unsigned int) block);
	print_uart0_str(" size: ");
	print_uart0_int((unsigned int) count);
	print_uart0_str("\n");
	return block;
}

void operator delete[](void* ptr) {
	allocator.free((unsigned int*)ptr);
	print_uart0_str("delete[]: ");
	print_uart0_int((unsigned int) ptr);
	print_uart0_str("\n");
}