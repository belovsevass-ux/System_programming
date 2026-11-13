ASM = fasm
CC = gcc
CFLAGS = -m32 -Wall -no-pie
LDFLAGS = -m32 -no-pie

all: program

lib.o: lib.asm
	$(ASM) lib.asm lib.o

program: main.c lib.o
	$(CC) $(CFLAGS) -o program main.c lib.o $(LDFLAGS)

clean:
	rm -f lib.o program

.PHONY: all clean