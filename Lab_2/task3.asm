format ELF executable 3
entry start

segment readable executable
start:
    mov ecx, 11
    mov ebx, 1
row_loop:
    push ecx
    mov ecx, ebx
col_loop:
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    push ecx
    mov ecx, char
    int 0x80
    pop ecx
    loop col_loop

    mov eax, 4
    mov ebx, 1
    mov edx, 1
    push ecx
    mov ecx, newline
    int 0x80
    pop ecx

    pop ecx
    inc ebx
    loop row_loop

    mov eax, 1
    xor ebx, ebx
    int 0x80

segment readable writeable
char db '+'
newline db 10