
#include "crti.h"
#include "serial.h"

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
	return 0;
}

int atexit(void (*function)(void)){
	print_uart0_str("atexit \n");
	return 0;
}

