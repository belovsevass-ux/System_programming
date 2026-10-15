format ELF64
public _start

section '.bss' writeable
    buf rb 4096
    fd_in rq 1
    fd_out rq 1
    k_val rq 1

section '.text' executable

_start:
    mov rax, [rsp]
    cmp rax, 4
    jne exit_err

    mov rdi, [rsp+32]
    call atoi
    mov [k_val], rax

    mov rax, 2
    mov rdi, [rsp+16]
    xor rsi, rsi
    syscall
    mov [fd_in], rax

    mov rax, 0
    mov rdi, [fd_in]
    mov rsi, buf
    mov rdx, 4096
    syscall
    mov r12, rax

    mov rax, 3
    mov rdi, [fd_in]
    syscall

    mov rcx, 0
    mov rbx, [k_val]
dec_loop:
    cmp rcx, r12
    je write_out
    sub byte [buf+rcx], bl  ; ВОТ ЗДЕСЬ ВЫЧИТАНИЕ (расшифровка)
    inc rcx
    jmp dec_loop

write_out:
    mov rax, 2
    mov rdi, [rsp+24]
    mov rsi, 0x241
    mov rdx, 0644o
    syscall
    mov [fd_out], rax

    mov rax, 1
    mov rdi, [fd_out]
    mov rsi, buf
    mov rdx, r12
    syscall

    mov rax, 3
    mov rdi, [fd_out]
    syscall

    jmp exit_ok

exit_err:
    mov rax, 60
    mov rdi, 1
    syscall

exit_ok:
    mov rax, 60
    xor rdi, rdi
    syscall

atoi:
    xor rax, rax
.loop:
    movzx rdx, byte [rdi]
    test rdx, rdx
    jz .done
    cmp rdx, 10
    je .done
    imul rax, 10
    sub rdx, '0'
    add rax, rdx
    inc rdi
    jmp .loop
.done:
    ret