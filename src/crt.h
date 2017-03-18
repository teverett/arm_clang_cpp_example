
#ifndef __CRT_H
#define __CRT_H

void _init(void);
void _fini(void);
int c_entry();
int atexit(void (*function)(void));

#endif