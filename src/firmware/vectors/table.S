#include <avr/io.h>
.section ".vector", "x", @progbits

.extern	_start
.extern	__bad_interrupt
.extern	__timer2_pre

.align 2
/*
** Vector table
** @note:
** The lower address is defined as the reset vector
** (this is why we call _start entry)
*/
__vector:
	jmp	_start			; Manual reset, power-on, wathdog reset
	jmp	__bad_interrupt		; External Interrupt request 0
	jmp	__bad_interrupt		; External Interrupt request 1
	jmp	__bad_interrupt		; Pin change interrupt request 0
	jmp	__bad_interrupt		; Pin change interrupt request 1
	jmp	__bad_interrupt		; Pin change interrupt request 2
	jmp	__bad_interrupt		; Watchdog time out
	jmp	__bad_interrupt		; Timer 2 compare match a
	jmp	__bad_interrupt		; Timer 2 compare match b
	jmp	__timer2_pre		; Timer 2 overflow
	jmp	__bad_interrupt		; Timer 1 capture event
	jmp	__bad_interrupt		; Timer 1 compare match a
	jmp	__bad_interrupt		; Timer 1 compare match b
	jmp	__bad_interrupt		; Timer 1 overflow
	jmp	__bad_interrupt		; Timer 0 compare match a
	jmp	__bad_interrupt		; Timer 0 compare match b
	jmp	__bad_interrupt		; Timer 0 overflow
	jmp	__bad_interrupt		; SPI serial transfert complete
	jmp	__bad_interrupt		; USART rx complete
	jmp	__bad_interrupt		; USART data register empty
	jmp	__bad_interrupt		; USART tx complete
	jmp	__bad_interrupt		; ADC convertion complete
	jmp	__bad_interrupt		; EEPROM ready
	jmp	__bad_interrupt		; Analog comparator
	jmp	__bad_interrupt		; 2-wires serial interface
	jmp	__bad_interrupt		; Store program memory ready

.end
