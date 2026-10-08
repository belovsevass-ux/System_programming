format ELF64
public _start

section '.bss' writeable
    input_buf rb 32
    out_buf   rb 32
    n         rq 1
    rev       rq 1

section '.data' writeable
    msg_prompt db 'Enter n: '
    len_prompt = $ - msg_prompt
    msg_res db 'Reversed = '
    len_res = $ - msg_res
    newline db 10

section '.text' executable

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_prompt
    mov rdx, len_prompt
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buf
    mov rdx, 32
    syscall

    mov rdi, input_buf
    call atoi
    mov [n], rax

    mov rbx, [n]
    xor r12, r12
    
    test rbx, rbx
    jns reverse_loop
    neg rbx

reverse_loop:
    cmp rbx, 0
    je done_reverse

    xor rdx, rdx
    mov rax, rbx
    mov rcx, 10
    div rcx
    
    mov rbx, rax
    imul r12, 10
    add r12, rdx
    jmp reverse_loop

done_reverse:
    mov rax, [n]
    test rax, rax
    jns print_res
    neg r12

print_res:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_res
    mov rdx, len_res
    syscall

    mov rax, r12
    call print_number

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

atoi:
    xor rax, rax
    xor r8, r8
    mov r9, 1
    cmp byte [rdi], '-'
    jne .loop
    mov r9, -1
    inc rdi
.loop:
    movzx rdx, byte [rdi]
    test rdx, rdx
    jz .done
    cmp rdx, 10
    je .done
    cmp rdx, '0'
    jb .done
    cmp rdx, '9'
    ja .done
    imul rax, 10
    sub rdx, '0'
    add rax, rdx
    inc rdi
    jmp .loop
.done:
    imul rax, r9
    ret

print_number:
    lea rsi, [out_buf+32]
    mov r8, 10
    xor r9d, r9d
    test rax, rax
    jns .convert
    mov r9b, 1
    neg rax
.convert:
    xor edx, edx
    div r8
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .convert
    test r9b, r9b
    jz .output
    dec rsi
    mov byte [rsi], '-'
.output:
    lea rdx, [out_buf+32]
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    syscall
    ret