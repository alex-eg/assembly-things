section .data
format: db "%s", 10, 0
section .text

global main
extern printf

main:
        mov r14, rdi             ; argc
        mov r15, rsi             ; argv

print:  mov rdi, format
        mov rsi, [r15]
        mov rax, 0
        call printf

        add r15, 8

        dec r14
        cmp r14, 0
        jg print

        mov rax, 60
        mov rdi, 0
        syscall
