; Brandon Buckley
; Brandon_Buckley_Project2.asm
;
; TODO: help used

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