format ELF64
public _start

section '.bss' writeable
    input_buf rb 32
    out_buf   rb 32
    n         rq 1

section '.data' writeable
    msg_prompt db 'Enter n: '
    len_prompt = $ - msg_prompt
    msg_yes db 'Yes (non-decreasing)', 10
    len_yes = $ - msg_yes
    msg_no db 'No (not non-decreasing)', 10
    len_no = $ - msg_no

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
    mov r13, 1          ; флаг: 1 = OK, 0 = ошибка
    mov r12, 10         ; предыдущая цифра (10 больше любой цифры)

check_loop:
    cmp rbx, 0
    je check_done

    xor rdx, rdx
    mov rax, rbx
    mov rcx, 10
    div rcx             ; rdx = последняя цифра, rax = оставшееся число
    
    mov rbx, rax        ; сохраняем оставшееся число
    
    cmp rdx, r12        ; если текущая > предыдущей, то порядок нарушен
    jg bad_order
    
    mov r12, rdx        ; обновляем предыдущую
    jmp check_loop

bad_order:
    mov r13, 0
    jmp check_done

check_done:
    cmp r13, 1
    jne print_no

    ; Вывод "Yes"
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_yes
    mov rdx, len_yes
    syscall
    jmp exit

print_no:
    ; Вывод "No"
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_no
    mov rdx, len_no
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

atoi:
    xor rax, rax
    xor r8, r8
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
    ret