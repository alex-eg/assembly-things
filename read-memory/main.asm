;; This program prints msg using printf,
;; keeping track of passed length, which
;; is stored in the rbx register, which
;; is being preserved between function
;; calls, according to System V Abi for
;; amd64.

section .data
msg:    db "address: %c, count: %d", 10, 0
msglen: equ $-msg

section .text

global main
extern printf

main:
        mov rbx, 0
next:
        mov  rdi, msg
        mov  rsi, [msg + rbx]
        mov  rdx, rbx
        mov  rax, 0
        call printf

        inc  rbx
        cmp  rbx, msglen
        jl   next

        mov rax, 60
        mov rdi, 0
        syscall
