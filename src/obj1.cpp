
#include "obj1.hpp"

extern "C" {
	#include "serial.h"
}

Obj1::Obj1(int x) {
	print_uart0_str("ctor\n");
	this->x = x;
}

Obj1::Obj1() {
	print_uart0_str("ctor\n");
	x = 77;
}

Obj1::~Obj1(){
	print_uart0_str("dtor\n");
}

int Obj1::getX() {
		return x;
}
