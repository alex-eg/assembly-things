;;; calling convention for local functions is standard:
;;; rdi, rsi, rdx, rcx, r8, r9 are arguments
;;; rax is return register
;;; rbp, rbx, r12, r13, r14, r15 must be preserved between calls

section .data

width:    dq 128
height:   dq 128
usage:    db "usage: targa-gen <dest-file>", 10, 0
f_op_err: db "error opening file", 10, 0

section .bss
image: resb 49152

section .text

global _start

extern print
extern open_file
extern close_file
extern write_targa

_start:
        pop rbx                 ; argc
        mov rdi, rbx
        call check_argc
;; if check passes, opening file

        pop rdi                 ; program name
        pop rdi
        call open_file

        mov r12, rax

        cmp rax, -1
        je .exit_open_file_error

        mov rdi, r12            ; opened file
        mov rsi, [width]
        mov rdx, [height]

        push rax
        push rbx
        push rcx

        mov rcx, 0              ; offset
        mov rax, 0              ; qwords
.fill_image:
        xor rbx, rbx
        mov rbx, 888
        lea rcx, [image + rax]
        mov [rcx], bx

        inc rax
        cmp rax, 2
..@break:
        jg .fill_image

        pop rcx
        pop rbx
        pop rax

        mov rcx, image

        call write_targa

        mov rdi, r12
        call close_file

        mov rdi, 0
        jmp exit
.exit_open_file_error:
        mov rdi, f_op_err
        mov rsi, 0
        call print

        mov rdi, 2
        jmp exit

check_argc:
        enter 0, 0
        cmp rdi, 2
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
