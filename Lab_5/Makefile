ASM = fasm
CC = gcc

all: task3_asm task7_asm task7_decrypt_asm task7_c task7_decrypt_c

# Задача 3 (ассемблер вызывает C-функцию)
task3_asm: task3.asm task3_func.o
	$(ASM) task3.asm task3_asm.o
	ld -o task3_asm task3_asm.o task3_func.o -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2

task3_func.o: task3.c
	$(CC) -c -o task3_func.o task3.c

# Задача 7 (ассемблер)
task7_asm: task7.asm
	$(ASM) task7.asm task7_asm.o
	ld -o task7_asm task7_asm.o

task7_decrypt_asm: task7_decrypt.asm
	$(ASM) task7_decrypt.asm task7_decrypt_asm.o
	ld -o task7_decrypt_asm task7_decrypt_asm.o

# Задача 7 (только C)
task7_c: task7.c
	$(CC) -o task7_c task7.c

task7_decrypt_c: task7_decrypt.c
	$(CC) -o task7_decrypt_c task7_decrypt.c

clean:
	rm -f *.o task3_asm task7_asm task7_decrypt_asm task7_c task7_decrypt_c

.PHONY: all clean