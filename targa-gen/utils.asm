;;; calling convention for local functions is standard:
;;; rdi, rsi, rdx, rcx, r8, r9 are arguments
;;; rax is return register
;;; rbp, rbx, r12, r13, r14, r15 must be preserved between calls

section .text

global chunck_length
global print
global open_file
global close_file

chunk_length:
;; rdi is memory location
;; rsi is chunck end mark (byte)
;; returns length
        enter 0, 0
        mov rdx, rsi            ; save 2nd arg
        mov rsi, rdi
        mov rcx, 0              ; counter
.loop:
        lodsb
        cmp rax, rdx
        jne .increase

        mov rax, rcx
        leave
        ret
.increase:
        inc rcx
        jmp .loop

print:
;; rdi -- string or memory location
;; rsi -- char count. if equals zero, assuming string
;; returns 0
        enter 0, 0

        cmp rsi, 0
        je .print_string
;; when not a string
        mov rdx, rsi            ; character count
.print:
        mov rax, 1              ; sys_write
        mov rsi, rdi            ; location
        mov rdi, 1              ; stdout
        syscall

        mov rax, 0
        leave
        ret
.print_string:
        push rdi
        mov rsi, 0              ; null-termination
        call chunk_length
        pop rdi
        mov rdx, rax
        jmp .print

open_file:
;; rdi -- filename
;; returns pointer to file
        enter 0, 0

        mov rax, 2
        ; rdi already filled
        mov rsi, 101Q           ; O_WRONLY | O_CREAT
        mov rdx, 640Q           ; 644 access mode
        syscall

        leave
        ret

close_file:
        enter 0, 0
        mov rax, 3              ; close
        ; rdi already set
        syscall

        leave
        ret
