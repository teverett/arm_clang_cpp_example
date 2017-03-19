
#include "crti.h"
#include "serial.h"

typedef void (*func_ptr)(void);
 
extern func_ptr _init_array_start[0], _init_array_end[0];
extern func_ptr _fini_array_start[0], _fini_array_end[0];
 
void _init(void)
{
	print_uart0_str("crt.c _init\n");
	for ( func_ptr* func = _init_array_start; func != _init_array_end; func++ )
		(*func)();
}

void _fini(void)
{
	print_uart0_str("crt.c _fini\n");
	for ( func_ptr* func = _fini_array_start; func != _fini_array_end; func++ )
		(*func)();
}

func_ptr _init_array_start[0] __attribute__ ((used, section(".init_array"), aligned(sizeof(func_ptr)))) = { };
func_ptr _fini_array_start[0] __attribute__ ((used, section(".fini_array"), aligned(sizeof(func_ptr)))) = { };
