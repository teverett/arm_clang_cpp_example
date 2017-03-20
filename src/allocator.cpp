
extern "C" {
#include "serial.h"
}

#include "allocator.hpp"

Allocator::Allocator(unsigned int* heapstart){
	this->heapstart = heapstart;
	print_uart0_str("Allocator ctor\n");
}
Allocator::~Allocator(){
	print_uart0_str("Allocator dtor\n");
}

unsigned int* Allocator::allocate(unsigned int count){
	unsigned int* block =  (heapstart + (c * blocksize));
	c = c + 1;
	return block;
}

void Allocator::free(unsigned int* ptr){
	// freeing memory blocks is for the weak and the elderly
}
