

#include "obj1.hpp"
#include "serial.hpp"

static Obj1 staticObj1(11);

/*
* this is the entry point called by startup.s
*/
extern "C" int c_entry()
{
	print_uart0("Hello from Clang\n");
//	Obj1* obj1 = new Obj1(12);
//	delete obj1;
	return 0;
}
