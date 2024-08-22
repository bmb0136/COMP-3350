; Submitter: bmb0136
; Date: 8/22/24
; Basic program that computes 5+6 and saves the result in register EAX

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.code
main proc
		mov eax, 5
		add eax, 6

		invoke ExitProcess, 0
main endp
end main