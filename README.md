# Diy launchpad

[![release][1]][2] [![workflow][3]][4] ![size][20] [![issues][5]][6]

**DIY launchpad with Atmega328p-AU**

---

### Build

```
avr-gcc -Os -DF_CPU=8000000 -mmcu=atmega328p -c src/main.c
avr-gcc -DF_CPU=8000000 -mmcu=atmega328p -o name.elf main.o
avr-objcopy -O ihex name.elf name.hex

sudo avrdude -c usbasp -p atmega328p -U flash:w:name.hex
```

[1]: https://img.shields.io/github/v/release/GreenDjango/diy-launchpad?maxAge=600
[2]: https://github.com/GreenDjango/diy-launchpad/releases "GitHub release (latest by date)"
[3]: https://img.shields.io/github/workflow/status/GreenDjango/diy-launchpad/GCC-CI?maxAge=600
[4]: https://github.com/GreenDjango/diy-launchpad/actions "GitHub Workflow Status"
[5]: https://img.shields.io/github/license/GreenDjango/diy-launchpad?maxAge=2592000
[6]: LICENSE "GitHub license"
[20]: https://img.shields.io/github/repo-size/GreenDjango/diy-launchpad?maxAge=600 "GitHub repo size"
