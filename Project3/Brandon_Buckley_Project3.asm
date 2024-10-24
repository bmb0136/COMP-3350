; Brandon Buckley
; Brandon_Buckley_Project2.asm
;
; I used https://en.wikipedia.org/wiki/X86_instruction_listings for a list of available instructions

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