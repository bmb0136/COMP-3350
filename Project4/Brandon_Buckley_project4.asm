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
	sub esp, 52 ; Stack grows down!

	; Initialize both arrays to zero
	; 52 / 4 = 13, so just mov 13 zeroes
	mov ecx, 13
L_init:
	mov DWORD PTR [esp + ecx - 1], 0
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

	; Compare the two arrays

	mov eax, 1               ; Assume they are equal and look for a difference

	mov ecx, 26              ; Looping over the count arrays, not the strings
L_compare:
	mov bl, [esp + ecx - 1]  ; bl = count_s1[ecx - 1];
	mov bh, [esp + ecx + 25] ; bh = count_s2[ecx - 1];
	cmp bl, bh
	je skip_not_equal
	mov eax, 0               ; bl != bh -> s1 and s2 are not anagrams
	mov ecx, 1               ; break; If ecx is set to 0 here the ecx will underflow when the loop subtracts 1
skip_not_equal:
	loop L_compare

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