/*
** Linker script used by the Paddiy Epitech projet
** Author:
** 	Theo COUSINET
** 	Yann MAGNIN
*/


/*
** @note:
** The entry point is useless because on the startup
** the MCU will generate RESET interupt and this interrupt
** will redirect to the "real" firmware entry.
*/
OUTPUT_FORMAT("elf32-avr", "elf32-avr", "elf32-avr")
OUTPUT_ARCH(avr:5)


/*
** @note:
** All addresses are based on the linker script
** dumped using "avr-gcc -Wl,--verbose -mmcu=atmega328p"
** and using the ATMega328p Manual Section 7. AVR Memories
*/
MEMORY
{
	flash	(rx)	: o = 0x000000, l = 32k
	sram	(rwx)	: o = 0x800060, l = 2k
	eeprom	(rx)	: o = 0x810000, l = 1k
}

/*
** @note:
** Discribe programe organistation
*/
SECTIONS
{
	/*
	** ROM part
	*/
	.text : {
		/* The fist part of code need to be the vector table */
		*(.vector)
    		KEEP(*(.vectors))

		/* Startup routine */
		*(.ctr0)

		/* Internal text space */
		*(.text)
	} > flash

	/*
	** RAM part
	** @note: Should be manually dump into
	** sram memory
	*/
	.data : {
		/*
		** Set the .data section at the top of
		** the SRAM
		**
		** @note:
		** The "real" .data section should be
		** dumped during the startup
		*/
		PROVIDE(__data_sram_start = .) ;
		*(.data)
		*(.data*)
	} > sram AT> flash
	__data_flash_start = LOADADDR(.data);
	__data_size = SIZEOF(.data);

	/* 
	** BSS stuff going to RAM, this section is 
	** to be stripped from the ELF file later
	** and wiped at startup.
	**/
	.bss (NOLOAD) : {
		PROVIDE(__bss_sram_start = .) ;
		*(.bss)
		*(.bss*)
		*(COMMON)
	} > sram : NONE
	__bss_size = SIZEOF(.bss);

	/*
	** Unwanted sections
	*/
	/DISCARD/ : {
		*(.debug)
		*(.debug*)
		*(.gnu.*)
		*(.jcr)
		*(.eh_frame_hdr)
		*(.eh_frame)
		*(.comment)
		*(.gnu*)
	}
}
