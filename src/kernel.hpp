
#ifndef __KERNEL_HPP
#define __KERNEL_HPP

class Kernel {
private:
	void test_heap_object();
	void test_automatic_object();
	void report_image();
public: 
	Kernel();
	~Kernel();
	int run();
};

#endif