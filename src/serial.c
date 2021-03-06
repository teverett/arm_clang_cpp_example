#include "serial.h"
#include "str.h"

volatile unsigned int * const UART0DR = (unsigned int *) 0x101f1000;

void print_uart0_str(const char *s) {
	while (*s != '\0') {
		*UART0DR = (unsigned int) (*s);
		s++;
	}
}

void print_uart0_int(int n) {
	char str[255];
	itoa(n, str);
	print_uart0_str(str);
}
