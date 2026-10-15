format ELF64
public _start

extrn reverse_lines

section '.text' executable

_start:
    ; Проверяем аргументы (prog, in_file, out_file)
    mov rax, [rsp]
    cmp rax, 3
    jne exit_err

    ; Передаем аргументы в C-функцию
    mov rdi, [rsp+16]   ; in_file
    mov rsi, [rsp+24]   ; out_file
    call reverse_lines

    ; Завершаем программу
    mov rax, 60
    xor rdi, rdi
    syscall

exit_err:
    mov rax, 60
    mov rdi, 1
    syscall