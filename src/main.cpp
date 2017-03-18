

#include "obj1.hpp"

extern "C" {
	#include "serial.h"
	#include "crt.h"
}

//static Obj1* staticObj1 = new Obj1(12);

extern "C" void test_heap_object() {
	Obj1* obj1 = new Obj1(77);
	int xx = obj1->getX();
	print_uart0_int(xx);
	print_uart0_str("\n");
	delete obj1;
}

extern "C" void test_automatic_object() {
//	int xx = staticObj1->getX();
//	print_uart0_int(xx);
//	print_uart0_str("\n");
}

/*
* this is the entry point called by crt.c
*/
extern "C" int main()
{

	print_uart0_str("Hello from Clang\n");
	test_heap_object();
//	test_automatic_object();


	return 0;
}



