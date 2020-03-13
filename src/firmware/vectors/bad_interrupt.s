.text

.global	__bad_interrupt
.type	__bad_interrupt, @function

.align 2
__bad_interrupt:
	jmp 	0x00	; Force reset

.end
