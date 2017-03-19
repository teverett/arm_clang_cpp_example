

extern "C" {
#include "sections.h"
#include "serial.h"
}

/*
* custom new and delete operators needed by C++
*/

int c=0;
static int blocksize=1000;

void* operator new  (unsigned int count){

	unsigned int t = (unsigned int) __heap_top;
	unsigned int block = t+(c*blocksize);
	c=c+1;

//	print_uart0_str("new: ");
//	print_uart0_int((unsigned int) __heap_top);
//	print_uart0_str("\n");

	return (void*) block;
}

void operator delete (void* ptr){
	print_uart0_str("delete\n");
}
