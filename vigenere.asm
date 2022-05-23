%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;put in stack the three arithmetical registers to use them 
	push    edx
    push    ebx
    push    ecx    

    mov     eax, 0
    push    eax
    push    eax

    xor     eax, eax
    xor     edx, edx
    xor     ecx, ecx

    ;use ebx as a iterator for plaintext
    mov     ebx, 0

for:
    xor     eax, eax
    ;iterate through plaintext character by character and try to apply rotation
    ;on the current character with the order of the current letter from key
    mov     al, [esi + ebx]
    add     ebx, 1
    
    ;increment the contor of plaintext but dont increment at this moment the 
    ;iterator for key
    xor     edx, edx
    mov     edx, [esp + 4] ;current key_pointer

    cmp     al, 32
    je      altceva

    xor     ecx, ecx

    mov     cl, [edi + edx] ;current letter_from_key

    cmp     al, 96
    jle     could_be_uppercase

    cmp     al, 122
    jle     could_be_lowercase

could_be_uppercase:
    cmp     al, 64
    jle     altceva

    cmp     al, 90
    jg      altceva

could_be_lowercase:
    ;increment the iterator for key only if the plaintex[ebx] is letter
    add     edx, 1
    cmp     edx, [esp + 12] 
    jl is_in_key

    mov     edx, 0


is_in_key:
    cmp     cl, 97
    jl is_uppercase

    sub     cl, 97
    jmp     next


is_uppercase:
    sub     cl, 65

next:
    add     al, cl    

    cmp     al, 90
    jle     is_upper

    cmp     al, 96
    jg      is_upper

    sub     al, 91
    add     al, 'A'
    
    jmp     altceva

is_upper:
    cmp     eax, 122
    jle     altceva
    
    sub     al, 123
    add     al, 'a'

    jmp     altceva

altceva:

    ;copy from stack the address where the letter should be putted
    mov     [esp + 4], edx
    mov     edx, [esp + 16]
    mov     [edx + ebx - 1], al

    xor     ecx, ecx

    ;copy from stack the length of plaintext
    mov     ecx, [esp + 8]
    ;compare the iterator from ebx with the length of plaintext
    cmp     ebx, ecx
    jl      for
    ;loop

    pop     eax
    pop     eax
    pop     ecx
    pop     ebx
    pop     edx

    xor     eax, eax
    xor     ebx, ebx
    xor     ecx, ecx
    xor     edx, edx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
