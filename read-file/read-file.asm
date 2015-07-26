section .data

usage: db "Usage: read-file <source> <dest>", 10, 0
f_err: db "Cannot open file", 10, 0

r: db "r", 0
w: db "w", 0

section .bss
buf: resb 512

section .text

global main

extern printf
extern fopen
extern fclose
extern fread
extern fwrite
extern feof

main:
        mov r14, rdi            ; argc
        mov r15, rsi            ; argv

        cmp r14, 3
        jne exit_usage          ; if not enough arguments

        add r15, 8              ; open file for reading
        mov rdi, [r15]
        mov rsi, r
        call fopen

        cmp rax, 0
        je exit_read_file_open_error

        mov r13, rax            ; store pointer to opened file

        add r15, 8              ; open file for writing
        mov rdi, [r15]
        mov rsi, w
        call fopen

        cmp rax, 0
        je exit_write_file_open_error

        mov r12, rax            ; store pointer to file
read_chunk:
        mov rdi, buf
        mov rsi, 1
        mov rdx, 512
        mov rcx, r13
        call fread

        mov rdi, buf
        mov rsi, 1
        mov rdx, rax            ; write exactly number of bytes read
        mov rcx, r12
        call fwrite

        mov rdi, r13
        call feof
        cmp rax, 0
        jne close_files_and_exit

        jmp read_chunk
exit_write_file_open_error:
        mov rdi, f_err
        mov rax, 0
        call printf

        mov rdi, r13
        call fclose

        mov rsi, 3
        jmp exit
exit_read_file_open_error:
        mov rdi, f_err
        mov rax, 0
        call printf

        mov rsi, 2
        jmp exit
exit_usage:
        mov rdi, usage
        mov rax, 0
        call printf
        mov rsi, 1
        jmp exit
close_files_and_exit:
        mov rdi, r12
        call fclose

        mov rdi, r13
        call fclose
        jmp exit_normal
exit_normal:
        mov rsi,0
        jmp exit
exit:
        mov rax, 60
        syscall
