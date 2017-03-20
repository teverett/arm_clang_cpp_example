#include "obj1.hpp"

extern "C" {
#include "serial.h"
}

Obj1::Obj1(int x) {
	this->x = x;
	print_uart0_str("Obj1 int ctor with value: ");
	print_uart0_int(this->x);
	print_uart0_str("\n");
}

Obj1::Obj1() {
	print_uart0_str("Obj1 default ctor\n");
	x = 33;
}

Obj1::~Obj1() {
	print_uart0_str("Obj1 dtor with value: ");
	print_uart0_int(x);
	print_uart0_str("\n");
}

int Obj1::getX() {
	return x;
}
