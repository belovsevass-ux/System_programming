format ELF executable 3
entry start

segment readable executable
start:
    mov eax, 1234567890
    xor ebx, ebx
    mov ecx, 10

sum_loop:
    xor edx, edx
    div ecx
    add ebx, edx
    test eax, eax
    jnz sum_loop

    mov eax, ebx
    xor edx, edx
    mov ecx, 10
    div ecx
    add al, '0'
    add dl, '0'
    
    mov [result], al
    mov [result+1], dl
    mov [result+2], 10
    
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 3
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

segment readable writeable
result db 0, 0, 0