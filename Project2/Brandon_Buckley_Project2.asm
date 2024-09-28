.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
.data
input BYTE 1, 2, 3, 4, 5, 6, 7, 8
shift BYTE 2
.code
main PROC
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0



	INVOKE ExitProcess, 0
main ENDP
END main