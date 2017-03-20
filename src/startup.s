.global _reset
_reset:
 LDR sp, =__stack_top
 BL c_entry
 B .
 