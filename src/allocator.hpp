#ifndef __ALLOCATOR_HPP
#define __ALLOCATOR_HPP

/*
 * Behold! The worst imaginable Heap Implementation!
 */

class Allocator {
private:
	unsigned int c = 0;
	unsigned int blocksize = 100;
	unsigned int* heapstart =0;
public:
	Allocator(unsigned int* heapstart);
	~Allocator();

	unsigned int* allocate(unsigned int count);
	void free(unsigned int* ptr);
};

#endif
