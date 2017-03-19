.global _Reset
_Reset:
 LDR sp, =__stack_top
 BL c_entry
 B .
 