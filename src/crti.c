#include "crti.h"
#include "serial.h"

typedef void (*func_ptr)(void);

extern func_ptr __init_array_begin[0], __init_array_end[0];
extern func_ptr __fini_array_begin[0], __fini_array_end[0];

void _init(void) {
	print_uart0_str("crt.c _init\n");
	for (func_ptr* func = __init_array_begin; func != __init_array_end; func++)
		(*func)();
}

void _fini(void) {
	print_uart0_str("crt.c _fini\n");
	for (func_ptr* func = __fini_array_begin; func != __fini_array_end; func++)
		(*func)();
}

func_ptr __init_array_begin[0] __attribute__ ((used, section(".init_array"), aligned(sizeof(func_ptr)))) = { };
func_ptr __fini_array_begin[0] __attribute__ ((used, section(".fini_array"), aligned(sizeof(func_ptr)))) = { };
