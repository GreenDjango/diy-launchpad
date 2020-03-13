#!/usr/bin/make -f
## ---
##	Project: Paddiy - DIY Lauchpad
##	Author:
##		Theo COUSINET
##		Yann MAGNIN
## ---




##--
##	Static variables
##--
COMPILER	:= avr-
CC		:= $(COMPILER)gcc
OBJCOPY		:= $(COMPILER)objcopy
OBJDUMP		:= $(COMPILER)objdump
FLASHER		:= avrdude

BUILD_DIR	:= build
DEBUG_DIR	:= debug

NAME 		:= paddiy
BIN 		:= $(NAME).hex
MMAP		:= $(DEBUG_DIR)/$(NAME).map
ELF		:= $(DEBUG_DIR)/$(NAME).elf

LIB		:= -lgcc
HEADER 		:= -Iinclude
LDFLAG		:= -Wl,-M -T $(NAME).ld
CFLAGS		:= -Werror -Wall -W -Wextra -std=c11 \
			-Wno-unused-const-variable -Wno-unused-function \
			-Wno-unused-variable -Wno-unused-but-set-variable \
			-Wno-unused-parameter
EXTRAFLAGS	:= -Os -mmcu=atmega328p -ffreestanding \
			-nostdlib -D F_CPU=8000000

red		:= \033[1;31m
green		:= \033[1;32m
blue		:= \033[1;34m
white		:= \033[1;37m
nocolor		:= \033[1;0m




##--
##	Makefile Fix
##--
define n
# Force newline character

endef




##---
##	Automated variables
##---
# Get all directory
SRC		:=
DIRECTORY	:= $(shell find src -not -path "*/\.*" -type d)
# Get all source files
$(foreach path,$(DIRECTORY),$(eval		\
	SRC	+= $$(wildcard $(path)/*.c)	$n\
	SRC	+= $$(wildcard $(path)/*.S)	$n\
	SRC	+= $$(wildcard $(path)/*.s)	$n\
))
# Geneate all object files
OBJ	:= $(patsubst src_%,$(BUILD_DIR)/%.o,$(subst /,_,$(basename $(SRC))))




##---
##	General rules
##---
all: $(BIN)

$(BIN): $(OBJ) | $(DEBUG_DIR)
	$(CC) $(LDFLAG) $(EXTRAFLAGS) $(OBJ) -o $(ELF) > $(MMAP)
	$(OBJCOPY) -O ihex $(ELF) $@

$(BUILD_DIR) $(DEBUG_DIR):
	@ printf "Create $(blue)$@$(nocolor) directory\n"
	@ mkdir -p $@

flash: $(BIN)
	sudo $(FLASHER) -c usbasp -p atmega328p -U flash:w:$^




##---
##	Debugging rules
##---
help:
	@ echo 'src: $(SRC)'
	@ echo 'obj: $(OBJ)'
	@ echo 'directory: $(DIRECTORY)'

asm:
	@ $(OBJDUMP) -D $(ELF) | less

map:
	@ cat $(MMAP) | less

elf:
	@ $(OBJDUMP) -h $(DEBUG)/$(NAME).elf



##---
##	  Automated rules
##---
define rule-src
$(patsubst src_%,$(BUILD_DIR)/%.o,$(subst /,_,$(basename $1))): $1 | $(BUILD_DIR)
	@ printf "compiling $(white)$$<$(nocolor)..."
	@ $(CC) $(CFLAGS) $(EXTRAFLAGS) -o $$@ -c $$< $(HEADER) -lgcc
	@ printf "$(green)[ok]$(nocolor)\n"
endef

$(foreach source,$(SRC),$(eval		\
	$(call rule-src,$(source)))	\
)



##---
##	Cleaning rules
##---
clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(DEBUG_DIR)

fclean: clean
	rm -f $(BIN)

re: fclean all




.PHONY: all flash
.PHONY: help asm map elf
.PHONY: clean fclean re
