
#include "crti.h"

extern int main();

typedef void (*atexit_function)(void);

/*
* array of exit functions
*/
#define MAX_ATEXIT_FUNCTIONS 255
static atexit_function* atexit_functions[255];
static int total_atexit_functions=0;

void init_atexit(){
	for (int i=0; i<MAX_ATEXIT_FUNCTIONS;i++){
		atexit_functions[i]=0;
	}
}

void run_atexit(){
	int i=0;
	while (atexit_functions[i]!=0){
		atexit_function func = atexit_functions[i];
		(*func)();
		i++;
	}
}

int atexit(void (*func)(void)){
	atexit_functions[total_atexit_functions++]=func;
	return 0;
}

/**
* c_entry is called from startup.s.  It calls _init to set up static data, then main, then shuts down static data
*/
int c_entry() {
	/*
	* init exit functions
	*/
	init_atexit();
	/*
	* init
	*/
	_init();
	atexit(_fini);
	/*
	* run
	*/
	main();
	/*
	* exit functions
	*/
	run_atexit();
	return 0;
}



