; Brandon Buckley
; Brandon_Buckley_Project5.asm
;
; Help used:
; - https://en.wikipedia.org/wiki/X86_instruction_listings

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
.data
.code
main PROC
	INVOKE ExitProcess, 0
main ENDP
END main