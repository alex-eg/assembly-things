section .text
global _start
_start:
        pop rbx                 ; argc

next_argv:
        mov r8, 0               ; argv[i] length counter
        pop r9                  ; argv[i]
        mov rsi, r9
get_size_loop:
        lodsb
        cmp rax, 0
        jne increase
print:
        mov rax, 1
        mov rdi, 1
        mov rsi, r9
        mov rdx, r8
        syscall

        dec rbx
        cmp rbx, 0
        jg  next_argv

        push 10
        mov rax, 1
        mov rdi, 1
        mov rsi, rsp
        mov rdx, 1
        syscall

        mov rax, 60
        mov rsi, 0
        syscall
increase:
        inc r8
        jmp get_size_loop
