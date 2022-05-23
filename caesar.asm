%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;push edx in stack to be ready to be used in solving this task
	push 	edx

	xor 	eax, eax
	xor 	ebx, ebx
	xor 	edx, edx

	;calculate the remainder of the key divided to the number of letters from 
	;english alphabet 
	mov 	eax, edi
	mov 	ebx, 26
	div 	ebx	
	
	xor 	ebx, ebx

	mov 	ebx, edx

	;take character by character in a loop to check if it is letter and apply 
	;the rotation on it
	;else the algorithm doesn't modify the character
each_letter:
	mov 	al, byte [esi + ecx - 1]
	
	;check if it is space skip it
	cmp 	eax, 32
	je 		altceva

	;check if it is letter
	cmp 	eax, 96
	jle 	could_be_uppercase
	cmp 	eax, 122
	jle 	could_be_lowercase

could_be_uppercase:

	cmp 	eax, 64
	jle 	altceva
	cmp 	eax, 90
	jg 		altceva

could_be_lowercase:
	;add the key and then check if it is exceed the chracter ascii code and 
	;apply the rotation
	add 	eax, ebx	
	cmp 	eax, 90
	jle 	is_upper
	cmp 	eax, 96
	jg 		is_upper

	sub 	eax, 91
	add 	eax, 'A'
	
	jmp 	altceva

is_upper:
	cmp 	eax, 122
	jle 	altceva
	
	sub 	eax, 123
	add 	eax, 'a'

	jmp 	altceva

altceva:

	;pop from stack edx so we can store at the address with edx offset the new 
	;character
	pop 	edx
	
	mov 	[edx + ecx - 1], al	

	push 	edx

	xor 	edx, edx

	loop each_letter

	pop 	edx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
