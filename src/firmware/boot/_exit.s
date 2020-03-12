.text

.global _exit
.type	_exit, @function 

/*
** _exit(void)
** @note:
** It will wait manual reset.
** We use the "sleep" instruction to avoid
** power consumption.
*/
_exit:
	cli		; force disable interrupt
	sleep		; force CPU to sleep
	rjmp 	. - 4	; If the CPU woke up, jump at <sleep>

.end
