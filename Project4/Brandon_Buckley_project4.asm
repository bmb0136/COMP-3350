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
	mov 0, DWORD PTR [esp + ecx - 1]
	loop L_init

	mov esi, OFFSET s1
	mov edi, esp
	mov ecx, LENGTHOF s1
	call CountLetters

	mov esi, OFFSET s2
	lea edi, [esp + 26]
	mov ecx, LENGTHOF s2
	call CountLetters

	; Deallocate extra memory before exiting!
	add esp, 52
	INVOKE ExitProcess, 0
main ENDP
end main