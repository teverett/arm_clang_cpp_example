#ifndef __DERIVEDCLASS1_HPP
#define __DERIVEDCLASS1_HPP

#include "baseclass1.hpp"

class DerivedClass1 : public BaseClass1 {
public:
	DerivedClass1();
	virtual ~DerivedClass1();
	int getN();
};

#endif
