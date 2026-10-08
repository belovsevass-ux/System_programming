ASM = fasm
CC = gcc

all: task7_asm task11_asm task12_asm task7_c task11_c task12_c

task7_asm: task7.asm
	$(ASM) task7.asm task7_asm.o
	ld -o task7_asm task7_asm.o

task11_asm: task11.asm
	$(ASM) task11.asm task11_asm.o
	ld -o task11_asm task11_asm.o

task12_asm: task12.asm
	$(ASM) task12.asm task12_asm.o
	ld -o task12_asm task12_asm.o

task7_c: task7.c
	$(CC) -o task7_c task7.c

task11_c: task11.c
	$(CC) -o task11_c task11.c

task12_c: task12.c
	$(CC) -o task12_c task12.c

clean:
	rm -f *.o task7_asm task11_asm task12_asm task7_c task11_c task12_c

.PHONY: all clean
