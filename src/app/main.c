#include <avr/io.h>
#include <stddef.h>
#include <stdint.h>
#include <util/delay.h>

int main(void)
{
    // Set pin 13 to output (On-chip LED)
    DDRB = 0x20; // output
    PORTB = 0x20; // Set LED to low

    //pC5:0 = ANALOG
    //pD7:0 || pB7:0 = DIGITAL
    //pC6 = REST
    //pD0 = RX
    //pD0 = TT

    // Toggle lopp.
    while (1) {
        //__asm__ volatile("sleep");
        PORTB = PORTB ^ 0x20;
        _delay_ms(500);
    }

    return (0);
}