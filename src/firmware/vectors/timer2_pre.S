#include <avr/io.h>
.text

.global	__timer2_pre
.type	__timer2_pre, @function

.align 2
/*
** Timer 2 handler prototype
** TODO:
**	Callback management
**	Real time management
*/
__timer2_pre:
	; Manually clear timer flag
	lds	r18, TIFR2
	andi	r18, ~(1 << TOV2)
	sts	TIFR2, r18

	; Manually reload the counter
	ldi	r18, 0xff
	sts	TCNT2, r18

	; Led off
	; call 	toggle_test
	lds	r18, PORTB
	ldi	r19, (1 << PORTB5)
	eor	r18, r19 
	sts	PORTB, r18

	; pouet
	rjmp 	. - 4
	nop

	; return properly
	reti
.end
