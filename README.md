# Diy launchpad

[![release][1]][2] [![workflow][3]][4] ![size][20] [![issues][5]][6]

**DIY launchpad with Atmega328p-AU**

```
avr-gcc -Os -DF_CPU=8000000 -mmcu=attiny85 -c led_flash.c
avr-gcc -DF_CPU=8000000 -mmcu=attiny85 -o led_flash.elf led_flash.o
avr-objcopy -O ihex led_flash.elf led_flash.hex
```

[1]: https://img.shields.io/github/v/release/GreenDjango/diy-launchpad?maxAge=600
[2]: http://commonmark.org "GitHub release (latest by date)"
[3]: https://img.shields.io/github/workflow/status/GreenDjango/diy-launchpad/Node.js%20CI?maxAge=600
[4]: http://commonmark.org "GitHub Workflow Status"
[5]: https://img.shields.io/github/license/GreenDjango/diy-launchpad?maxAge=2592000
[6]: LICENSE "GitHub license"
[20]: https://img.shields.io/github/repo-size/GreenDjango/diy-launchpad?maxAge=600 "GitHub repo size"
