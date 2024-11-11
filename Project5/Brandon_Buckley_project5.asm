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
input	BYTE	"MEMORY"
key		BYTE	"BAD"
options	BYTE	1
output	BYTE	0 DUP(LENGTHOF input)
.code
main PROC
	INVOKE ExitProcess, 0
main ENDP

; GetKeyByte(i)
; Arguments: eax = i
; Returns: eax = key[i % len(key)] - 'A'
; Preconditions: len(key) > 0, eax >= 0
GetKeyByte PROC
	push ebx
	mov ebx, LENGTHOF key
	call Modulo
	pop ebx

	movzx eax, [key + eax]
	sub eax, 'A'

	ret
GetKeyByte ENDP

; Mod(x, y)
; Arguments: eax=x, ebx=y
; Returns: eax = x % y
; Preconditions: eax >= 0, ebx != 0
Modulo PROC
	push edx

	mov edx, 0
	div ebx
	mov eax, edx

	pop edx
Modulo ENDP

END main