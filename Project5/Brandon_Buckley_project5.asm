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
input	BYTE	"JPUESZSBAPANNHTXRTLBVLL"
key		BYTE	"ABCXYZ"
options	BYTE	0
output	BYTE	0 DUP(LENGTHOF input)
.code
main PROC
	INVOKE ExitProcess, 0
main ENDP

; Decrypt()
; Arguments: none
; Returns: output contains input decryped
; Preconditions: len(output)==len(input), 1<=len(key)<len(input)
Decrypt PROC
	mov ecx, LENGTHOF input

L_decrypt:
	; eax = key[(ecx - 1) % len(key)] - 'A'
	mov eax, ecx
	sub eax, 1
	call GetKeyByte

	; eax -= input[ecx - 1] - 'A'
	movzx ebx, [input + ecx - 1]
	sub ebx, 'A'
	xchg eax, ebx
	sub eax, ebx

	; eax %= 26
	mov ebx, 26
	call Modulo

	; output[ecx - 1] = eax;
	add eax, 'A'
	mov [output + ecx - 1], al

	loop L_decrypt

	ret
Decrypt ENDP

; Encrypt()
; Arguments: none 
; Returns: output contains input encrypted
; Preconditions: len(output)==len(input), 1<=len(key)<len(input)
Encrypt PROC
	mov ecx, LENGTHOF input

L_encrypt:
	; eax = key[(ecx - 1) % len(key)] - 'A'
	mov eax, ecx
	sub eax, 1
	call GetKeyByte

	; eax += input[ecx - 1] - 'A'
	movzx ebx, [input + ecx - 1]
	sub ebx, 'A'
	add eax, ebx

	; eax %= 26
	mov ebx, 26
	call Modulo

	; output[ecx - 1] = eax;
	add eax, 'A'
	mov [output + ecx - 1], al

	loop L_encrypt

	ret
Encrypt ENDP


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
; Preconditions: ebx != 0
Modulo PROC
	cmp eax, 0
	jge positive
L_add:
	add eax, ebx
	js L_add
	ret
positive:
	push edx

	mov edx, 0
	div ebx
	mov eax, edx

	pop edx

	ret
Modulo ENDP

END main