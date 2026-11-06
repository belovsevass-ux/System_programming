format ELF executable 3
entry start

N equ 66
M equ 6
K equ 11

segment readable executable
start:
    mov edi, N
    mov ecx, K
row_loop:
    push ecx
    mov ecx, M
col_loop:
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    push ecx
    mov ecx, char
    int 0x80
    pop ecx
    dec edi
    loop col_loop

    mov eax, 4
    mov ebx, 1
    mov edx, 1
    push ecx
    mov ecx, newline
    int 0x80
    pop ecx

    pop ecx
    loop row_loop

    mov eax, 1
    xor ebx, ebx
    int 0x80

segment readable writeable
char db '+'
newline db 10