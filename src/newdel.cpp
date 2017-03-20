
extern "C" {
#include "image.h"
#include "serial.h"
}

/*
 * custom new and delete operators needed by C++
 */
/*
 * Behold! The worst imaginable Heap Implementation!
 */
int c = 0;
static int blocksize = 100;

void* operator new(unsigned int count) {
	unsigned int t = (unsigned int) &__heap_top;
	unsigned int* block = (unsigned int*) (t + (c * blocksize));
	c = c + 1;

	print_uart0_str("new: ");
	print_uart0_int((unsigned int) block);
	print_uart0_str(" size: ");
	print_uart0_int((unsigned int) count);
	print_uart0_str("\n");

	return (void*) block;
}

void operator delete(void* ptr) {
	print_uart0_str("delete: ");
	print_uart0_int((unsigned int) ptr);
	print_uart0_str("\n");
}
