; Brandon Buckley
; Brandon_Buckley_Project3.asm
;
; I used https://en.wikipedia.org/wiki/X86_instruction_listings for a list of available instructions
; I asked in class if the shift variable will ever be negative

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
.data
input	BYTE	5, 0Ah, 2, 6, 0Ch, 9, 4
shift	DWORD	3
output	BYTE	LENGTHOF input DUP(?)
.code
main PROC
	; Array pointers
	mov esi, 0
	mov edi, shift

	; Setup loop
	mov ecx, LENGTHOF input
loop1:

	; Wrap edi around if it is >= len(input)
	; Would have use modulo but I can't find a modulo instruction
	cmp edi, LENGTHOF input
	jl skip_wrap
	mov edi, 0
skip_wrap:

	; Don't need to check edi < 0 since:
	; - shift is always positive (asked in class)
	; - edi is initalized to shift
	; - edi will only ever increase or be snapped down to 0

	; Copy value (have to use 2 instructions because I cannot directly copy)
	mov al, [input + esi]
	mov [output + edi], al

	; esi++; edi++;
	inc esi
	inc edi

	loop loop1

	INVOKE ExitProcess, 0
main ENDP
END main