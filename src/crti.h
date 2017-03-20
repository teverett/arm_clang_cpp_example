#ifndef __CRT_H
#define __CRT_H

void _init(void);
void _fini(void);
int atexit(void (*function)(void));

#endif
