#include <stdint.h>
#include <stddef.h>
#include <util/delay.h>
#include <avr/io.h>

int main(void)
{
	// Set pin 13 to output (On-chip LED)
	DDRB = 0b00100000;	// output
	PORTB = 0b00000000;	// Set LED to low

	// Toggle lopp.
	while (1)
	{
		PORTB = PORTB ^ 0b00100000;
		_delay_ms(1000);
	}
	return (0);
}
