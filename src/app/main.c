#include <stdint.h>
#include <stddef.h>
#include <util/delay.h>
#include <avr/sleep.h>
#include <avr/io.h>

/*void test_toggle(void)
{
	//PORTB = 0b00000000;
	//PORTB = PORTB ^ 0b00100000;
}*/

int main(void)
{
	// Set pin 13 to output (On-chip LED)
	DDRB = 0b00100000;	// output
	PORTB = 0b00000000;	// Set LED to low

	// Try to init timer2
	TIMSK2 = 0x00;		// Force disable timer interrupt
	TCCR2A = 0x00;		// Disable OCMA / OCMB and select normal waveform generation
	TCCR2B = 0x00;		// Stop timer clock
	OCR2A  = 0x00; 		// Output Comparator disable
	OCR2B  = 0x00; 		// Output Comparator disable 
	TCNT2  = 0xff;		// Reset timer counter.
	TIMSK2 = 0x01;		// Enable only timer overflow interrupt
	TCCR2B = 0x03;		// select Clock to clk/1024 and start it !

	// Force enable interrupt
	__asm__ volatile ("sei");

	// LED debug
	PORTB = PORTB | 0b00100000;
	while (1);

	// Toggle lopp.
	while (1);

	return (0);
}
