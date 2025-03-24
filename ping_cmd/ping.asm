global _start

section .data

address:	; the address we gonna talk with
	dw 2
	dw 0	; port 
	db 8	; next 4 bytes are address to ping
	db 8
	db 8
	db 8
	dd 0	; padding used (as the structure has to be 16 bytes
	dd 0

packet:
	db 8	; type of packet ICMPv4
	db 0	; the code
checksum:
	dw 9
	dw 0	; identifier ?
	dw 1	; squence number

buffer:		; that will receive the packet coming in
	times 1024 db 0xff

good:
	db 'good'

fail:
	db 'fail'

section .text

_start:
	mov rax, 41 	; socket syscall
	mov rdi, 2	; family (IPv4)
	mov rsi, 3	; type (raw socket)
	mov rdx, 1	; protocol (ICMP)
	syscall

	mov r12, rax
	not word [checksum]	; to make valid checksum
	mov rax, 44		; sendto syscall
	mov rdi, r12		; file descriptor of socket
	mov rsi, packet		; packet buffer
	mov rdx, 8		; packet buffer length
	mov r10, 0		; flags (no flags)
	mov r8, address		; address buffer
	mov r9, 16		; length of address buffer
	syscall

	mov rax, 45		; recv from syscall
	mov rdi, r12		; socket file descriptor
	mov rsi, buffer		; buffer to get packet
	mov rdx, 1024		; length of packet buffer
	mov r10, 0
	mov r8, 0
	mov r9, 0		; the link for the address
	syscall

	cmp word [buffer+20], 0	; to skip IP Header --> ICMP Type : 0 (echo reply)
	jne failure
	
	mov rax, 1	; syscall number of write
	mov rdi, 1	; stdout file descriptor
	mov rsi, good
	mov rdx, 4 	; good = 4 bytes
	syscall

failure:
	jmp $
	
	



