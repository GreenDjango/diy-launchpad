#include <avr/io.h>
.section ".ctr0", "x", @progbits

.global _start
.type	_start, @function 

.extern	main
.extern	_exit
.extern __data_sram_start
.extern __data_flash_start
.extern __data_size
.extern	__bss_sram_start
.extern __bss_size 

.align 2
/*
** _start(void)
** @note:
** Startup function.
** Load and initlialise hardware part
**
** FIXME
** The header file <avr/common.h> which list all common
** registers seems not work with atmega328p because the
** __SFR_OFFSET need to be 0 but for the <avr/iom328p.h>
** it's should not be 0. So privide our own header ?
*/
_start:
	/*
	** Clear Status Register
	** @note
	** Block global interrupt and clear other bits
	*/
	eor	r1, r1				; wipe r1
	sts 	SREG, r1 			; SREG = 0x00


	/*
	** Setup stack address
	** @note
	** We use the end of the SRAM.
	** TODO: Find define for end of SRAM ?
	*/
	ldi	r26, 0xff			; Stack start address (LSB)
	ldi	r27, 0x08			; Stack start address (MSB)
	sts 	SPL, r26			; SPL = LSB stack address part
	sts 	SPH, r27			; SPH = MSB stack address part


	/*
	** dump data section
	*/
data_dump:
	ldi	r16, lo8(__data_size)		; .data section size (LSB)
	ldi	r17, hi8(__data_size)		; .data section size (MSB)
	or	r16, r17			; r6 = r16 | r17
	tst	r16 				; check if the data size is 0...
	breq 	bss_wipe			; ..If yes, jump at <bss_wipe>
	ldi	r16, lo8(__data_size)		; .data section size (LSB)
	ldi	r26, lo8(__data_sram_start)	; .data sram start address (XL)
	ldi	r27, hi8(__data_sram_start)	; .data sram start address (XH)
	ldi	r30, pm_lo8(__data_flash_start)	; .data flash start address (ZH) 
	ldi	r31, pm_hi8(__data_flash_start)	; .data flash start address (ZL) 
	rjmp 	. + 4

data_dloop:
	lpm	r0, Z+				; r0 = *(data_flash_addr++)
	st	X+, r0				; *(data_sram_addr++) = r0
	subi	r16, 0x01			; data size (LSB) - 1 (with carry)
	sbci	r17, 0x00			; data size (MSB) - Carry
	brne 	data_dloop			; if data size != 0, jump at <data_dloop>


	/*
	** Wipe bss sections
	*/
bss_wipe:
	ldi	r16, lo8(__bss_size)		; .bss section size (LSB)
	or	r16, r17			; r6 = r16 | r17
	tst	r16 				; check if the data size is 0...
	breq 	call_main			; ..If yes, jump at <bss_wipe>
	ldi	r17, hi8(__bss_size)		; .bss section size (MSB)
	ldi	r26, lo8(__bss_sram_start)	; .bss sram start address (XL)
	ldi	r27, hi8(__bss_sram_start)	; .bss sram start address (XH)
	rjmp 	. + 2

bss_wloop:
	st	X+, r1				; *(bss_sram++) = 0x00	
	subi	r16, 0x01			; bss size (LSB) - 1 (with carry)
	sbci	r17, 0x00			; bss size (MSB) - Carry
	brne 	bss_wloop			; if bss size != 0, jump at <bss_wloop>


	/*
	** Call main function
	*/
call_main:
	call 	main
	call	_exit

.end
