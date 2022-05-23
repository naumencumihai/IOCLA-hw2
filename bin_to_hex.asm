%include "io.mac"

section .text
    global bin_to_hex
    extern printf

section .data
    hexa_value dd 0
    values: db '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
    contor dd 0
    contor_hexa_value dd 0
    length dd 0
    sum dd 0
    start_4 dd 0

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

	mov     eax, 0

    ;initialize some auxiliar values
    mov     [contor], eax
    mov     [sum], eax
    mov     [length], ecx
    mov     [hexa_value], edx
    mov     [contor_hexa_value], eax

    xor     edx, edx

    ;calculate the remainder of the length of bin_sequence divided by 4
    mov     al, cl
    mov     bl, byte 4
    div     bl

    ;we try to calculate the hexa value for the reminder 
    mov     bl, ah
    mov     [start_4], bl

    ;put in start_4 value the position where we could take 4 by 4 elements 
    ;to calculate the hexa value

    cmp     bl, 0
    je      for_four

    ;if the remainder is 0 jump to the final_for which means that the length
    ;is multiple of four

    sub     bl, 1

    xor     eax, eax
    xor     ecx, ecx
    xor     edx, edx

    ;iterating through the remainder to calculate the value in hexa using 
    ;shifters 

for:
    mov     eax, [contor]
    mov     cl, [esi + eax]

    ;compare the current character with 0 ascii value
    cmp     cl, 48
    je      is_zero

    ;is not zero then shift it with 3 - iterartor number
    mov     edx, ebx
    sub     edx, eax

    mov     ecx, 1
    
    cmp     dl, 3
    jne     shift_two_times
    shl     ecx, 3
    jmp     shifted

shift_two_times:
    cmp     dl, byte 2 
    jne     shift_one_time
    shl     ecx, 2
    jmp     shifted

shift_one_time:
    cmp     dl, byte 1
    jne     shifted
    shl     ecx, 1
    jmp     shifted

shifted:
    
    mov     edx, [sum]
    add     edx, ecx

is_zero:    

    ;sum the numbers
    mov     [sum], edx

    add     eax, 1
    mov     [contor], eax

    cmp     al, bl
    jle     for

    mov     ecx, [sum]

    ;put the ecx value from values vector
    mov     cl, [values + ecx]

    xor     edx, edx

    mov     dl, [contor_hexa_value]

    mov     ebx, [hexa_value]
    mov     [ebx], byte cl

    inc     edx
    mov     [contor_hexa_value], edx
    

for_four:
    ;take groups of four to calculate the hexa_value
    xor     edx, edx    

    mov     ebx, [start_4]
    mov     ecx, 0

    ;take the first element in the group of four
    mov     eax, [esi + ebx]
    cmp     al, 48
    je      next1
    ;if is not zero shift it and add the new number to edx which is a 
    ;container for the sum of four elements
    mov     ecx, 1
    shl     ecx, 3

next1:
    
    add     edx, ecx

    mov     ecx, 0

    ;take the second element in the group of four
    mov     eax, [esi + ebx + 1]
    cmp     al, 48
    je      next2
    mov     ecx, 1
    shl     ecx, 2

next2:

    add     edx, ecx

    mov     ecx, 0

    ;take the third element in the group of four
    mov     eax, [esi + ebx + 2]
    cmp     al, 48
    je      next3
    mov     ecx, 1
    shl     ecx, 1

next3:

    add     edx, ecx

    mov     ecx, 0

    ;take the fourth element in the group of four
    mov     eax, [esi + ebx + 3]
    cmp     al, 48
    je      next4
    mov     ecx, 1
    shl     ecx, 0

next4:

    add     edx, ecx

    ;take the edx value from values vector
    mov     edx, [values + edx]

    xor     ebx, ebx
    xor     ecx, ecx
    
    ;put it at the specified address
    mov     cl, [contor_hexa_value]

    mov     ebx, [hexa_value]

    mov     [ebx + ecx], dl

    inc     ecx
    mov     [contor_hexa_value], ecx

    mov     ebx, [start_4]
    add     ebx, 4

    mov     [start_4], ebx

    mov     ecx, [length]

    cmp     ebx, ecx
    jge     out
    jl      for_four

out:

    ;add \n to the end of the string
    mov     eax, [contor_hexa_value]

    mov     edx, [hexa_value]
    mov     ebx, [length]

    mov     byte [edx + eax], 0x0A

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
