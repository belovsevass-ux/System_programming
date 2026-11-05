format ELF executable 3
entry start

segment readable executable
start:
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80

segment readable writeable
msg db 'Belov', 10, 'Sevastian', 10, 10
msg_len = $ - msg