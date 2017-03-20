#ifndef __IMAGE_H
#define __IMAGE_H

extern unsigned int __startup_begin;
extern unsigned int __startup_end;

extern unsigned int __text_begin;
extern unsigned int __text_end;

extern unsigned int __bss_begin;
extern unsigned int __bss_end;

extern unsigned int __data_begin;
extern unsigned int __data_end;

extern unsigned int __rodata_begin;
extern unsigned int __rodata_end;

extern unsigned int __init_array_begin;
extern unsigned int __init_array_end;

extern unsigned int __fini_array_begin;
extern unsigned int __fini_array_end;

extern unsigned int __heap_bottom;
extern unsigned int __heap_top;
extern unsigned int __heap_size;

extern unsigned int __stack_bottom;
extern unsigned int __stack_top;
extern unsigned int __stack_size;

#endif
