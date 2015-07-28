section .text
global chunck_length
global print

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
