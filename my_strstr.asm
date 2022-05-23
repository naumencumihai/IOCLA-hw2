%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    mov     dword [ebp - 4], 0      ;iterator for haystack
    mov     dword [ebp - 8], 0      ;iterator for needle

    mov     dword [ebp - 12], ecx   ;haystack_len
	
    ;push arithmetical registers to be able to use them
	push    edx
    push    ecx
    push    ebx

    xor     eax, eax
    xor     ebx, ebx
    xor     ecx, ecx
    xor     edx, edx

    ;iterate through characters of haystack search for the first character 
    ;which is equal with
    ;the first character from the needle
    ;then we increment the iterator for needle
    ;if there are difference between the two compared characters the iterator 
    ;for needle string
    ;is reseted to 0
    ;at the end we check if the iterator is equal to needle_len to decide if 
    ;the string was found
while:
    xor     ecx, ecx
    mov     ecx, [esp + 4]

    cmp     dword [ebp - 4], ecx
    jg      end


    xor     ecx, ecx
    mov     ecx, [esp + 8]

    cmp     dword [ebp - 8], ecx
    jg      end

    xor     ecx, ecx
    xor     edx, edx

    mov     edx, dword [ebp - 4]
    mov     cl, byte [esi + edx]

    xor     edx, edx
    
    mov     ebx, [esp]
    mov     edx, dword [ebp - 8]
    mov     al, byte [ebx + edx]

    xor     edx, edx

    cmp     al, cl    
    jne     reinit_contor_needle

    cmp     dword [ebp - 8], 0
    jne     increment_j

    mov     edx, dword [ebp - 4]

    mov     [edi], dword edx


increment_j:
    
    add     dword [ebp - 8], 1
    
    xor     edx, edx
    mov     edx, [esp + 8]
    cmp     dword [ebp - 8], edx
    
    je      end 

    jmp     increment_i


reinit_contor_needle:
    mov     dword [ebp - 8], 0      ;reinit contor needle
    

increment_i:
    add     dword [ebp - 4], 1

    jmp     while
    
end:

    mov     edx, [esp + 8]
    cmp     dword [ebp - 8], edx
    je      found
    cmp     dword [ebp - 8], 0
    jne     found

    mov     eax, [esp + 4]
    add     eax, 1

    mov     [edi], eax

found:

    pop     ebx
    pop     ecx
    pop     edx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
