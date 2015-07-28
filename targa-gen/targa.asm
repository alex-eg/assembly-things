;;; calling convention for local functions is standard:
;;; rdi, rsi, rdx, rcx, r8, r9 are arguments
;;; rax is return register
;;; rbp, rbx, r12, r13, r14, r15 must be preserved between calls

%macro write_data 3             ; file, buffer, count

        mov rax, 1
        mov rdi, %1
        mov rsi, %2
        mov rdx, %3
        syscall

%endmacro

section .data

header:   db 0,0,2,0,0,0,0,0

x_origin: db 0,0
y_origin: db 0,0
depth:    db 24
image_descriptor: db 00_00_0000b

footer: db 0,0,0,0,0,0,0,0, "TRUEVISION-XFILE.", 0

section .text

global write_targa

write_targa:
;; rdi - opened for writing file
;; rsi - width pixels
;; rdx - height pixels
;; rcx - pointer to pixels
        enter 0, 0

        mov r12, rdi
        mov r13, rsi
        mov r14, rdx
        mov r15, rcx

        write_data r12, header,   8
        write_data r12, x_origin, 2
        write_data r12, y_origin, 2
        push r13
        write_data r12, rsp,      2
        push r14
        write_data r12, rsp,      2
        write_data r12, depth,    1
        write_data r12, image_descriptor, 1

        mov rax, r13
        mul r14
        mov r14, 3
        mul r14
        mov rbx, rax

        write_data r12, r15, rbx
        write_data r12, footer, 26

        leave
        ret
