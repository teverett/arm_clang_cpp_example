

#include "obj1.hpp"
#include "serial.hpp"
#include "str.hpp"

static Obj1* staticObj1 = new Obj1(12);

extern "C" void _init(void);
extern "C" void _fini(void);

extern "C" void test_heap_object() {
	Obj1* obj1 = new Obj1(12);
	int xx = obj1->getX();
	print_uart0_int(xx);
	print_uart0_str("\n");
	delete obj1;
}

extern "C" void test_automatic_object() {
	int xx = staticObj1->getX();
	print_uart0_int(xx);
	print_uart0_str("\n");
}

/*
* this is the entry point called by startup.s
*/
extern "C" int c_entry()
{
	_init();
	print_uart0_str("Hello from Clang\n");
//	test_heap_object();
	test_automatic_object();
	_fini();

	return 0;
}


typedef void (*func_ptr)(void);
 
extern func_ptr _init_array_start[0], _init_array_end[0];
extern func_ptr _fini_array_start[0], _fini_array_end[0];
 
extern "C" void _init(void)
{
	for ( func_ptr* func = _init_array_start; func != _init_array_end; func++ )
		(*func)();
}

extern "C" void _fini(void)
{
	for ( func_ptr* func = _fini_array_start; func != _fini_array_end; func++ )
		(*func)();
}

func_ptr _init_array_start[0] __attribute__ ((used, section(".init_array"), aligned(sizeof(func_ptr)))) = { };
func_ptr _fini_array_start[0] __attribute__ ((used, section(".fini_array"), aligned(sizeof(func_ptr)))) = { };

