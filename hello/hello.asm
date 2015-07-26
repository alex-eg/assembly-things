section .data
text:   db "Hello, %s!", 10, 0

section .bss
name:   resb 64

section .text

global main
extern printf
extern fgets
extern stdin

main:
        mov  rdi, name
        mov  rsi, 64
        mov  rdx, [stdin]
        mov  rax, 0
        call fgets

        mov rdi, text
        mov rsi, name
        mov rax, 0
        call printf

        mov rax, 60
        mov rdi, 0
        syscall
