

#include "obj1.hpp"
#include "serial.hpp"
#include "str.hpp"

static Obj1 staticObj1(11);

extern "C" void test_heap_object() {
	Obj1* obj1 = new Obj1(12);
	int xx = obj1->getX();
	char str[255];
	itoa(xx, str);
	print_uart0(str);
	print_uart0("\n");
	delete obj1;
}

extern "C" void test_automatic_object() {
	int xx = staticObj1.getX();
	char str[255];
	itoa(xx, str);
	print_uart0(str);
	print_uart0("\n");
}

/*
* this is the entry point called by startup.s
*/
extern "C" int c_entry()
{
	print_uart0("Hello from Clang\n");
//	test_heap_object();
	test_automatic_object();

	return 0;
}


