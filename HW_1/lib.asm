format ELF

public create_array
public fill_random
public count_primes
public count_even
public get_odd_numbers
public free_array

section '.text' executable

; int* create_array(int size)
; Аргумент: size (4 байта) находится по адресу [esp+4] после push ebp
create_array:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov ecx, [ebp + 8]  ; size
    mov edx, 4
    imul ecx, edx       ; size * 4
    
    mov eax, 192        ; sys_mmap2
    xor ebx, ebx        ; addr = 0
    mov edx, 3          ; PROT_READ | PROT_WRITE
    mov esi, 0x22       ; MAP_PRIVATE | MAP_ANONYMOUS
    mov edi, -1         ; fd = -1
    xor ebp, ebp        ; ВНИМАНИЕ: здесь мы затираем ebp, но он нам больше не нужен для возврата
    int 0x80
    
    ; Восстанавливаем ebp для возврата
    mov ebp, esp
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

; void fill_random(int* arr, int size)
; Аргументы: arr [ebp+8], size [ebp+12]
fill_random:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi

    mov esi, [ebp + 8]  ; arr
    mov ecx, [ebp + 12] ; size
    mov eax, 12345      ; seed

fill_loop:
    imul eax, 1103515245
    add eax, 12345
    and eax, 0x7FFFFFFF
    mov ebx, 100
    xor edx, edx
    div ebx
    mov [esi], edx
    
    add esi, 4
    dec ecx
    jnz fill_loop

    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

; int count_primes(int* arr, int size)
; Аргументы: arr [ebp+8], size [ebp+12]
count_primes:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov esi, [ebp + 8]  ; arr
    mov ecx, [ebp + 12] ; size
    xor edi, edi        ; счетчик

prime_loop:
    mov eax, [esi]
    cmp eax, 2
    jl not_prime

    mov ebx, 2
check_div:
    cmp ebx, eax
    jge is_prime

    push eax
    xor edx, edx
    div ebx
    cmp edx, 0
    pop eax
    je not_prime

    inc ebx
    jmp check_div

is_prime:
    inc edi

not_prime:
    add esi, 4
    dec ecx
    jnz prime_loop

    mov eax, edi
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

; int count_even(int* arr, int size)
; Аргументы: arr [ebp+8], size [ebp+12]
count_even:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push esi

    mov esi, [ebp + 8]  ; arr
    mov ecx, [ebp + 12] ; size
    xor ebx, ebx

even_loop:
    mov eax, [esi]
    test eax, 1
    jnz not_even
    inc ebx

not_even:
    add esi, 4
    dec ecx
    jnz even_loop

    mov eax, ebx
    pop esi
    pop ecx
    pop ebx
    pop ebp
    ret

; int get_odd_numbers(int* arr, int size, int* result)
; Аргументы: arr [ebp+8], size [ebp+12], result [ebp+16]
get_odd_numbers:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov esi, [ebp + 8]  ; arr
    mov ecx, [ebp + 12] ; size
    mov edi, [ebp + 16] ; result
    xor ebx, ebx

odd_loop:
    mov eax, [esi]
    test eax, 1
    jz skip_odd

    mov [edi], eax
    add edi, 4
    inc ebx

skip_odd:
    add esi, 4
    dec ecx
    jnz odd_loop

    mov eax, ebx
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

; void free_array(int* arr, int size)
; Аргументы: arr [ebp+8], size [ebp+12]
free_array:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov ecx, [ebp + 12] ; size
    mov edx, 4
    imul ecx, edx

    mov eax, 91         ; sys_munmap
    mov ebx, [ebp + 8]  ; arr
    int 0x80

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret