format ELF executable 3
entry start

segment readable executable
start:
    mov ecx, len_S
    mov esi, S + len_S - 1

print_loop:
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    push ecx
    mov ecx, esi
    int 0x80
    pop ecx

    dec esi
    loop print_loop

    mov eax, 1
    xor ebx, ebx
    int 0x80

segment readable writeable
S db 'AMVtdiYVETHnNhuYwnWDVBqL'
len_S = $ - S