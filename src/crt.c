
#include "crt.h"

extern int main();

/**
* c_entry is called from startup.s.  It calls _init to set up static data, then main, then shuts down static data
*/
int c_entry() {
	print_uart0_str("crt.c _init\n");
	_init();
	print_uart0_str("crt.c main\n");
	main();
	print_uart0_str("crt.c _fini\n");
	_fini();
}

int atexit(void (*function)(void)){
	print_uart0_str("atexit \n");
}

typedef void (*func_ptr)(void);
 
extern func_ptr _init_array_start[0], _init_array_end[0];
extern func_ptr _fini_array_start[0], _fini_array_end[0];
 
void _init(void)
{
	for ( func_ptr* func = _init_array_start; func != _init_array_end; func++ )
		(*func)();
}

void _fini(void)
{
	for ( func_ptr* func = _fini_array_start; func != _fini_array_end; func++ )
		(*func)();
}

func_ptr _init_array_start[0] __attribute__ ((used, section(".init_array"), aligned(sizeof(func_ptr)))) = { };
func_ptr _fini_array_start[0] __attribute__ ((used, section(".fini_array"), aligned(sizeof(func_ptr)))) = { };
