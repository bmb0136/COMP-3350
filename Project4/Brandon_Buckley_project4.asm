; Brandon Buckley
; Brandon_Buckley_Project4.asm
;
; TODO: help used


.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
.data
s1	BYTE	"GARDEN"
s2	BYTE	"DANGER"
.code
main PROC
	; I would like to allocate 2 26 byte arrays to the stack
	; But I can't exactly push 52 bytes so I'm just going to do this
	; Layout:
	; &count_s1[0] = esp
	; &count_s2[0] = esp + 26
	sub esp, 52

	; Initialize both arrays to zero
	; 52 / 4 = 13, so just mov 13
	mov ecx, 13
L_init:
	mov DWORD PTR [esp + ecx - 1], 0
	loop L_init

	mov esi, OFFSET s1
	mov edi, esp
	mov ecx, LENGTHOF s1
	call CountLetters

	mov esi, OFFSET s2
	lea edi, [esp + 26]
	mov ecx, LENGTHOF s2
	call CountLetters

	; Compare the two arrays
	; Assume they are equal and look for a difference
	mov eax, 1

	mov ecx, 26
L_compare:
	; bl = count_s1[ecx - 1]
	mov bl, [esp + ecx - 1]
	; bh = count_s2[ecx - 1]
	mov bh, [esp + ecx + 25] ; + 26 - 1 = + 25
	cmp bl, bh
	je skip_not_equal
	; bl != bh -> s1 and s2 are not anagrams
	mov eax, 0
	; break
	mov ecx, 0
skip_not_equal:
	loop L_compare

	; Deallocate extra memory before exiting!
	add esp, 52
	INVOKE ExitProcess, 0
main ENDP

; CountLetters(char* str, unsigned char* counts, size_t length)
; Arguments: esi = &str[0], edi = &counts[0], ecx = length
; Returns: counts[i] contains the count of the (i + 1)th letter of the alphabet in str (0 -> A, 1 -> B, etc.)
; Preconditions: counts is initialized to all zero
CountLetters PROC
	; Save registers
	push eax

L_count:
	; eax = str[ecx - 1]
	movzx eax, BYTE PTR [esi + ecx - 1]
	; bytes[eax - 'A']++;
	inc BYTE PTR [edi + eax - 'A']
	loop L_count

	; Retrieve registers
	pop eax
	ret
CountLetters ENDP

end main