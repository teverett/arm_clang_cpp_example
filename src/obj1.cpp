
#include "obj1.hpp"

extern "C" {
	#include "serial.h"
}

Obj1::Obj1(int x) {
	print_uart0_str("Obj1 int ctor with value: ");
	print_uart0_int(x);
	print_uart0_str("\n");
	this->x = x;
}

Obj1::Obj1() {
	print_uart0_str("Obj1 default ctor\n");
	x = 77;
}

Obj1::~Obj1(){
	print_uart0_str("Obj1 int dtor with value: ");
	print_uart0_int(x);
	print_uart0_str("\n");
}

int Obj1::getX() {
		return x;
}
