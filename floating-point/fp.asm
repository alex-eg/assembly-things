section .data
	align 32
a:      dq 0.5, 0.6, 0.7, 0.8
b:      dq 0.4, 0.3, 0.2, 0.1
fmt:    db "Result: %.9f %.9f %.9f %.9f",10,0

section .text

global main
extern printf

main:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	vmovapd ymm0, [a]
	vsubpd ymm0, [b]
	vmovapd [rsp], ymm0

        mov rdi, fmt
	mov rax, 1
        call printf

	mov rsp, rbp
	pop rbp

	mov rax, 60
        mov rdi, 0
        syscall
