#include "kernel.hpp"
#include "obj1.hpp"

extern "C" {
#include "serial.h"
#include "image.h"
}

Kernel::Kernel() {
	print_uart0_str("Kernel::ctor\n");
}

Kernel::~Kernel() {
	print_uart0_str("Kernel::dtor\n");
}

int Kernel::run() {
	print_uart0_str("Kernel::run\n");
	report_image();
//	showbss();
	test_heap_object();
	test_automatic_object();
	test_array_new_del();
	return 0;
}

void Kernel::test_array_new_del(){
	char* cc = new char[255];
	delete[] cc;
}

void Kernel::showbss() {
	for (unsigned int* i=&__bss_begin; i<&__bss_end;i++){
		print_uart0_int((unsigned long) i);
		print_uart0_str(" : ");
		print_uart0_int((unsigned long) *i);
		print_uart0_str("\n");
	}
}

void Kernel::test_heap_object() {
	Obj1* obj1 = new Obj1(77);
	int xx = obj1->getX();
	print_uart0_int(xx);
	print_uart0_str("\n");
	delete obj1;
}

static Obj1 staticObj1(12);

void Kernel::test_automatic_object() {
	int xx = staticObj1.getX();
	print_uart0_int(xx);
	print_uart0_str("\n");
}

void Kernel::report_image() {
	print_uart0_str("__startup_begin: ");
	print_uart0_int((unsigned long) &__startup_begin);
	print_uart0_str("\n");

	print_uart0_str("__text_begin: ");
	print_uart0_int((unsigned long) &__text_begin);
	print_uart0_str("\n");

	print_uart0_str("__bss_begin: ");
	print_uart0_int((unsigned long) &__bss_begin);
	print_uart0_str("\n");

	print_uart0_str("__data_begin: ");
	print_uart0_int((unsigned long) &__data_begin);
	print_uart0_str("\n");

	print_uart0_str("__rodata_begin: ");
	print_uart0_int((unsigned long) &__rodata_begin);
	print_uart0_str("\n");

	print_uart0_str("__init_array_begin: ");
	print_uart0_int((unsigned long) &__init_array_begin);
	print_uart0_str("\n");

	print_uart0_str("__fini_array_begin: ");
	print_uart0_int((unsigned long) &__fini_array_begin);
	print_uart0_str("\n");

	print_uart0_str("__stack_top: ");
	print_uart0_int((unsigned long) &__stack_top);
	print_uart0_str("\n");

	print_uart0_str("__stack_size: ");
	print_uart0_int((unsigned long) &__stack_size);
	print_uart0_str("\n");

	print_uart0_str("__heap_bottom: ");
	print_uart0_int((unsigned long) &__heap_bottom);
	print_uart0_str("\n");

	print_uart0_str("__heap_size: ");
	print_uart0_int((unsigned long) &__heap_size);
	print_uart0_str("\n");
}

/*
 * this is the entry point called by crti.c
 */
extern "C" int main() {
	print_uart0_str("Hello from Clang\n");
	Kernel* kernel = new Kernel();
	int ret = kernel->run();
	delete kernel;
	return ret;
}
