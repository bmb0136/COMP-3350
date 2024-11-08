; Brandon Buckley
; Brandon_Buckley_Project4.asm
;
; Help used:
; - https://en.wikipedia.org/wiki/X86_instruction_listings

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
.data
s1	BYTE	"ABCD"
s2	BYTE	"ABCD"
.code
main PROC
	; I would like to allocate 2 26 byte arrays to the stack
	; But I can't exactly push 52 bytes so I'm just going to do this
	; Layout:
	; &count_s1[0] = esp
	; &count_s2[0] = esp + 26
	; 52 / 4 = 13, so just mov 13 DWORD zeroes
	mov ecx, 13
L_init:
	push DWORD PTR 0         ; Force MASM to push a DWORD instead of something else
	loop L_init

	; CountLetters(s1, count_s1, len(s1))
	mov esi, OFFSET s1
	mov edi, esp
	mov ecx, LENGTHOF s1
	call CountLetters

	; CountLetters(s2, count_s2, len(s2))
	mov esi, OFFSET s2
	lea edi, [esp + 26]      ; "lea" = Load Effective Address, allows you to store the result of the [reg + reg*x + y] syntax
	mov ecx, LENGTHOF s2
	call CountLetters

	mov eax, 1               ; Assume they are equal and look for a difference

	; Compare the two arrays
	; Found this interesting instruction on the Wikipedia instruction list
	; It does an array comparison in one instruction which is insane
	; esi = &array1[0], edi = &array2[0], ecx = number of bytes to compare
	mov ecx, 26
	mov esi, esp             ; &count_s1[0]
	; edi is already &count_s2[0]
	cld                      ; Set DF=0 (esi and edi point to the first elements)
	repe cmpsb               ; "cmpsb" = compare byte arrays, "repe" = repeat while equal (stop at first difference)

	je are_anagrams
	mov eax, 0
are_anagrams:

	add esp, 52              ; Deallocate extra memory before exiting!
	INVOKE ExitProcess, 0
main ENDP

; CountLetters(char* str, unsigned char* counts, size_t length)
; Arguments: esi = &str[0], edi = &counts[0], ecx = length
; Returns: counts[i] contains the count of the (i + 1)th letter of the alphabet in str (0 -> A, 1 -> B, etc.)
; Preconditions: counts is initialized to all zero
CountLetters PROC
	push eax                            ; Save eax

L_count:
	movzx eax, BYTE PTR [esi + ecx - 1] ; eax = str[ecx - 1];
	inc BYTE PTR [edi + eax - 'A']      ; bytes[eax - 'A']++;
	loop L_count

	pop eax                             ; Retrieve eax
	ret
CountLetters ENDP

end main