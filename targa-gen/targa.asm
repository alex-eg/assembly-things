;;; calling convention for local functions is standard:
;;; rdi, rsi, rdx, rcx, r8, r9 are arguments
;;; rax is return register
;;; rbp, rbx, r12, r13, r14, r15 must be preserved between calls

section .data
signature: db "TRUEVISION-XFILE.", 0
usage: db "usage: targa-gen <dest-file>", 10, 0

section .text

global _start

extern print
extern chunck_length

_start:
        pop rbx                 ; argc
        call check_argc
        mov rdi, 0
        jmp exit

check_argc:
        enter 0, 0
        cmp rbx, 1
        jne .print_usage_and_exit
        leave
        ret
.print_usage_and_exit:
        mov rdi, usage
        mov rsi, 0
        call print

        mov rdi, 1
        jmp exit
exit:
        mov rax, 60
        mov rsi, rdi
        syscall

        
