
all:
	avr-gcc -Os -DF_CPU=8000000 -mmcu=atmega328p -c src/main.c
	avr-gcc -DF_CPU=8000000 -mmcu=atmega328p -o blink.elf main.o
	avr-objcopy -O ihex blink.elf blink.hex

flash:
	sudo avrdude -c usbasp -p atmega328p -U flash:w:blink.hex


clean:
	rm -f main.o
	rm -f blink.elf
	rm -f blink.hex

.PHONY: all flash
