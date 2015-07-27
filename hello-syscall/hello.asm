section .data
hello: db "Hello, write syscall!", 10, 0
len: equ $ - hello

section .text

global _start

_start:
        mov rax, 1
        mov rdi, 1
        mov rsi, hello
        mov rdx, len
        syscall

        mov rax, 60
        xor rdi, rdi
        syscall
