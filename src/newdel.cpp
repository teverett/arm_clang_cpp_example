

extern "C" {
#include "serial.h"
}

/*
* custom new and delete operators needed by C++
*/


extern void* heap_top;
int c=0;
static int blocksize=1000;

void* operator new  (unsigned int count){
	print_uart0_str("new\n");
	unsigned int t = (unsigned int) heap_top;
	unsigned int block = t+(c*blocksize);
	c=c+1;
	return (void*) block;
}

void operator delete (void* ptr){
	print_uart0_str("delete\n");
}



