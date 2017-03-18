

#include "obj1.hpp"

static Obj1 staticObj1(11);

/*
* this is the entry point called by startup.s
*/
extern "C" int c_entry()
{
	Obj1* obj1 = new Obj1(12);
}
