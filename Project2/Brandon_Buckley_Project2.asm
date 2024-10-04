; Brandon Buckley
; Brandon_Buckley_Project2.asm
;
; I used the tutorials and slides in Canvas to setup the project

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
.data
input BYTE 1, 2, 3, 4, 5, 6, 7, 8
shift BYTE 2
.code
main PROC
	mov EAX, 0
	mov EBX, 0
	mov ECX, 0
	mov EDX, 0

	mov AH, input[0]
	add AH, shift

	mov AL, input[1]
	add AL, shift

	mov BH, input[2]
	add BH, shift

	mov BL, input[3]
	add BL, shift

	mov CH, input[4]
	add CH, shift

	mov CL, input[5]
	add CL, shift

	mov DH, input[6]
	add DH, shift

	mov DL, input[7]
	add DL, shift

	INVOKE ExitProcess, 0
main ENDP
END main