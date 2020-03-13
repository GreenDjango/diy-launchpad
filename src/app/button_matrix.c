#include <avr/io.h>
#include <stddef.h>
#include <stdint.h>
#include <util/delay.h>

#ifndef _END_MTX_
#define _END_MTX_ 255
#endif

int check_matrix(void)
{
    uint8_t mtx_out_port = PORTD; // Matrix Out Port
    uint8_t mtx_in_port = PORTC; // Matrix In Port
    uint8_t mtx_out[7] = { PORTD2, PORTD3, PORTD4, PORTD5, PORTD6, PORTD7, _END_MTX_ }; // Matrix Out Index
    uint8_t mtx_in[7] = { PORTC0, PORTC1, PORTC2, PORTC3, PORTC4, PORTC5, _END_MTX_ }; // Matrix In Index

    // Set all port 
    for (size_t i = 0; mtx_out[i] != _END_MTX_; i++) {
        mtx_out_port = mtx_out_port & ((1 << mtx_out[i]) ^ 1);
    }

    /*
        // Set pin 13 to output (On-chip LED)
    DDRB = 0b00100000; // output
    PORTB = 0b0; // Set LED to low
    DDRD = (1 << DDD4);
    PORTD = (1 << PORTD4);

    //pC5:0 = ANALOG
    //pD7:0 || pB7:0 = DIGITAL
    //pC6 = REST
    //pD0 = RX
    //pD0 = TT

    // Toggle lopp.
    while (1) {
        //__asm__ volatile("sleep");
        PORTB = PORTB ^ (1 << PORTB5);
        //PORTD = PORTD ^ (1 << PORTD4);
        _delay_ms(50);
    }*/

    return (0);
}