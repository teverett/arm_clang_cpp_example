
#include "obj1.hpp"
#include "serial.hpp"

Obj1::Obj1(int x) {
	print_uart0("ctor\n");
	this->x = x;
}

Obj1::~Obj1(){
	print_uart0("dtor\n");
}

int Obj1::getX() {
		return x;
}
