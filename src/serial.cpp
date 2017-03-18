
#include "serial.hpp"

volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
 
extern "C" void print_uart0(const char *s) {
	while(*s != '\0') { 
		*UART0DR = (unsigned int)(*s); 
 	s++; 
 	}
}



