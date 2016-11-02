	.globl main

 	.data
newline: .ascii "\n"
	.set newline_len, . - newline

	.bss	
argc:	.space 8

	.text	
main:
	movq $1, %rax
	movq $1, %rdi
	movq -16(%rsp), %rbx
	addq $48, (%rsp)
	movq %rsp, %rsi
	movq $SYS_EXIT, %rsi
	movq $1, %rdx
	syscall
	call printnl

	movq $1, %rax
	movq $1, %rdi
	movq 16(%rsp), %rsi
	movq $3, %rdx
	syscall
	call printnl
	
	movq $60, %rax
	xorq %rdi, %rdi
	syscall

printnl:
	movq $1, %rax
	movq $1, %rdi
	movq $newline, %rsi
	movq $newline_len, %rdx
	syscall
	ret
