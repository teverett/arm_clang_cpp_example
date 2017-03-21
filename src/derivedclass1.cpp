extern "C" {
#include "serial.h"
}

#include "derivedclass1.hpp"

DerivedClass1::DerivedClass1() {
	print_uart0_str("DerivedClass1 ctor\n");
}

DerivedClass1::~DerivedClass1(){
	print_uart0_str("DerivedClass1 dtor\n");
}

int DerivedClass1::getN() {
	return 55;
}


