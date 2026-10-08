format ELF64
public _start

section '.bss' writeable
    input_buf rb 32
    out_buf   rb 32
    n         rq 1
    sum       rq 1

section '.data' writeable
    msg_n db 'Enter number of judges: '
    len_n = $ - msg_n
    msg_vote db 'Enter vote (0 or 1): '
    len_vote = $ - msg_vote
    msg_res db 'Decision: '
    len_res = $ - msg_res
    newline db 10

section '.text' executable

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_n
    mov rdx, len_n
    syscall
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buf
    mov rdx, 32
    syscall
    mov rdi, input_buf
    call atoi
    mov [n], rax
    mov r12, rax        ; r12 = n (количество судей)

    xor rbx, rbx        ; rbx = сумма голосов
    xor r14, r14        ; r14 = счетчик цикла (i) - ИСПОЛЬЗУЕМ R14!

vote_loop:
    cmp r14, r12        ; сравниваем i с n
    je done_vote

    mov rax, 1
    mov rdi, 1
    mov rsi, msg_vote
    mov rdx, len_vote
    syscall
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buf
    mov rdx, 32
    syscall

    mov rdi, input_buf
    call atoi
    add rbx, rax        ; sum += vote

    inc r14             ; i++
    jmp vote_loop

done_vote:
    ; Проверка большинства (sum > n/2)
    mov rax, r12
    mov rcx, 2
    xor rdx, rdx
    div rcx             ; rax = n/2
    
    cmp rbx, rax
    jg majority_yes
    mov r13, 0          ; нет
    jmp print_result

majority_yes:
    mov r13, 1          ; да

print_result:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_res
    mov rdx, len_res
    syscall

    mov rax, r13
    call print_number

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

; Функция atoi (перевод строки в число)
atoi:
    xor rax, rax
    xor r8, r8
.loop:
    movzx rdx, byte [rdi]
    test rdx, rdx
    jz .done
    cmp rdx, 10         ; проверка на Enter
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
    ret

; Функция print_number
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