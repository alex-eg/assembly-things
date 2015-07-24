global main
extern printf

section .data
text: db "Hello, world!", 0

section .text
main:
        mov rdi, text
        mov rax, 0
        call printf
