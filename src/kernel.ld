
__qemu_load_address = 0x10000;
__stack_size = 0x1000;  /* 4k */
__heap_size = 0x10000;  /* 64k */

ENTRY(_reset)
SECTIONS
{
 . = __qemu_load_address;
.startup : 
	{ 
	__startup_begin = .;
	obj/startup.o(.text)
  	__startup_end = .; 
	}

.text : 
	{
	__text_begin = .;
	*(.text) 
  	__text_end = .; 
	}

.bss : 
	{ 
  	__bss_begin = .; 
	*(.bss COMMON)
  	__bss_end = .;  
	}

.data : 
	{ 
	__data_begin = .; 
	*(.data) 
  	__data_end = .; 
	}

.rodata :
	{
	__rodata_begin = .;
	*(.rodata) 
  	__rodata_end = .; 	
	}

/* Include the list of initialization functions sorted. */
.init_array :
	{
    PROVIDE(__init_array_begin = .);
    *(.init_array)
    KEEP (*(SORT( .init_array.*)))
    KEEP (*(.init_array))
    PROVIDE(__init_array_end = .);
	}

/* Include the list of termination functions sorted. */
.fini_array :
	{
    PROVIDE(__fini_array_begin = .);
    KEEP (*(SORT( .fini_array.*)))
    KEEP (*( .fini_array))
    PROVIDE(__fini_array_end = .);
	}

.ARM.exidx : 
	{
	*(.ARM.exidx)
	}

.ARM.attributes :
	{
	*(.ARM.attributes)
	}

.comment : 
	{
	*(.comment )
	}

/* define a stack. Remember that on ARM stacks grow down */
.stack :
	{
	/* stack */
	. = ALIGN(8);
	__stack_bottom = .;
	. = . + __stack_size;
	__stack_top = .;
	}

/* define a heap */
.heap :
	{	
	. = ALIGN(8);
	__heap_bottom = .;
	. = . + __heap_size;
	__heap_top = .;
	}
}
