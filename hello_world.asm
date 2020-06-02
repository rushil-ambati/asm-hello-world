; hello_world.asm, in 32-bit x86 assembly code
; by Rushil A.

; === THEORY ===
; the process of going from code to a running program is vaguely as follows
; [code]            ->      compiler        ->    [assembly] (not relevant here because we're starting in assembly)
; [assembly]        ->      assembler       ->    [object]
; [object]          ->      linker          ->    [executable]
; [executable]      ->      loader          ->    [memory]
; [memory]          ->      cpu             ->    [file descriptor]
; [file descriptor] ->      various buses   ->    [i/o resource] (in this case we output to stdout, in a terminal)

; === PRACTISE ===
; so assembly sequences operate with syscall operations where you select a function and load it into a register
; each one's got it's own parameters, and you load the arguments you wish to pass into the sequential registers
; the only registers we'll be using here are the 32-bit data registers eax through to edx

; to find out the syscalls to use and their respective codes, here i used the C headerfile "unistd" as a reference/index
;       #define __NR_exit 1             // 0x1 in hex
;       ...
;       #define __NR_write 4            // 0x4 in hex
;       ...
;       #define __NR_init_module 128    // 0x80 in hex

; in the end, we 'compile' the assembly code
; to assemble into an object file:      nasm -f elf32 -o hello_world.o  hello_world.asm
; to link into an executable file:      ld -m elf_i386 -o hello_world hello_world.o
; to run:                               hello 
; the output:                           Hello World! 

global _start                       ; this is actually quite interesting to note because it's kinda opposite to C 
                                    ; where everything is considered to be global unless stated otherwise

section .text:                      ; all of the program instructions, think of this as the 'main' method if you will
_start:
    ; print the message
    mov eax, 0x4                    ; use the 'write' syscall, supplying arguments below
                                    ; manual: "ssize_t write(int fd, const void *buf, size_t count);"
    mov ebx, 1                      ; fd - use stdout as the file descriptor
    mov ecx, message                ; *buf - use the message as the buffer
    mov edx, message_length         ; count - and supply the length of the string
    int 0x80                        ; invoke the syscall with the given arguments above
                                    ; 0x80 is the identifier for running a syscall 

    ; then exit the program
    mov eax, 0x1                    ; now using the 'exit' syscall
                                    ; manual: "void _exit(int status);"
    mov ebx, 0                      ; return value of 0
    int 0x80                        ; invoke the syscall again, but this time it's the exit one because we changed it above

section .data:                      ; we'll be initialising all our variables in this
                                    ; one thing that's curious is how and why variables and other sections are evaluated AFTER
                                    ; the _start/.text sections during runtime, because generally in programming languages you
                                    ; declare variables before you use them, but that doesn't seem to hold at this level.
    message: db "Hello World!", 0xA ; db here means "define bytes"
    message_length equ $-message    ; equ means equals
                                    ; $ being current location in memory
                                    ; - being the address of message
                                    ; so with both together we can calculate the length of the string through the address offset

