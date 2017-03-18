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

. = ALIGN(8);

. = . + 0x1000; /* 4kB of stack memory */
stack_top = .;

. = . + 0x100000; /* 4kB of heap memory */
heap_top = .;
}
