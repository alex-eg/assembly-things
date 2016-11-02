section .data
a:      dq 0.5
b:      dq 0.4
fmt:    db "Result: %s\n", 0

section .text

global main
extern printf

main:
        ;fld qword [a]
        ;fld qword [b]
        ;fsubp st1, st0
        ;fst qword [a]

        mov rdi, fmt
        mov rsi, 22
	mov rax, 0
        call printf

        mov rax, 60
        mov rdi, 0
        syscall
