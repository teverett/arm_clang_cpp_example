ENTRY(_Reset)
SECTIONS
{
 . = 0x10000;
.startup . : 
	{ 
	obj/startup.o(.text) 
	}

.text : 
	{
	*(.text) 
	}

.data : 
	{ 
	*(.data) 
	}

.bss : 
	{ 
	*(.bss COMMON) 
	}

/* Include the list of initialization functions sorted. */
.init_array :
{
    PROVIDE(_init_array_start = .);
    *(.init_array)
    KEEP (*(SORT( .init_array.*)))
    KEEP (*(.init_array))
    PROVIDE(_init_array_end = .);
}

/* Include the list of termination functions sorted. */
.fini_array :
{
    PROVIDE(_fini_array_start = .);
    KEEP (*(SORT( .fini_array.*)))
    KEEP (*( .fini_array))
    PROVIDE(_fini_array_end = .);
}

/* stack */
. = ALIGN(8);
. = . + 0x1000; /* 4kB of stack memory */
stack_top = .;

/* cheesy way to make a heap */
. = . + 0x100000; /* 4kB of heap memory */
heap_top = .;
}
