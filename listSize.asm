; CUSTOM LIBRARY

%macro print 2
	mov rax, 1 ; syscall mode
	mov rdi, 1 ; file descriptor for stdout
	mov rsi, %1 ; print ASCII 
	mov rdx, %2 ; size of data type for syscall 
	syscall
%endmacro

%macro return 0
	mov rax, 60 ; syscall mode
	mov rdi, 0 ; assume no error thrown
	syscall
%endmacro

%macro strToInt 0
	mov rax, [rsp] ; argc is in the top of the initial stack
	sub rax, 1 ; remove first arg (*path) 
	mov rbx, 4 ; we will do the loop four times
	mov r8, 10 ; store immediate of 10 in r8
	; rbx may hold an immediate with an integer >= 9
	; print macro only can spit out ASCII due to syscall limitations
	; we need to loop through the immediate to print out everything
	%%loop:
		; division op: rax / src -> div in rcx, mod in rdx
		sub rbx, 1
		mov rdx, 0 ; reset rdx to clear remainder
		div r8 ; get mod stored in r8
		add dl, 48 ; add lower 8 bits of rdx with  ASCII '0' 
		mov [buffer + rbx], dl
		cmp rbx, 0
		jne %%loop 
%endmacro
		
; PROGRAM 

; HEAP
section .bss
	buffer: resb 4 ; reserve 4 bytes for ASCII int (<= 9999) 	

; PROGRAM 
section .data
	new_line: db 10 ; ASCII for newline	
 
section .text
    global _start

_start:	
	strToInt ; modifies 4 ints in [rsp] to 4 bytes and places it in buffer	
	print buffer, 4 ; use a buffer because first arg in write syscall expects pointer 
	print new_line, 1 ; print new line
	return 
