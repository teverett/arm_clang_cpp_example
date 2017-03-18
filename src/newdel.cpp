

/*
* custom new and delete operators needed by C++
*/

extern void* heap_top;

void* operator new  (unsigned int count){
	// return the whole heap.  i am not a smart man, but i know that my program only has 1 "new"
	return heap_top;
}

void operator delete (void* ptr){

}

