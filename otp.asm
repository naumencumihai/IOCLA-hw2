%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

	xor    eax, eax
	xor    ebx, ebx

    ;iterate through plaintext and key character by character and apply xor 
    ;between two characters
loop_otp:
    ;used two registers to copy the character from esi + ecx - 1, -2 ....
	mov    al, byte [esi + ecx - 1]	
	mov    bl, byte [edi + ecx - 1]
	
	xor    eax, ebx
    ;put the result at the address from base edx with the same offset
	mov    [edx + ecx - 1], al
	
	xor    eax, eax
	xor    ebx, ebx

	loop loop_otp

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
