ASM = fasm
CC = gcc

all: task1 task2 task3

task1: task1.asm
	$(ASM) task1.asm task1.o
	ld -o task1 task1.o

task2: task2.asm
	$(ASM) task2.asm task2.o
	ld -o task2 task2.o

task3: task3.c
	$(CC) -o task3 task3.c

clean:
	rm -f *.o task1 task2 task3

.PHONY: all clean