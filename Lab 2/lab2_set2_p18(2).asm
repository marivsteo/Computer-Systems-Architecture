; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor.
; a,b,c,d - word, (a-b-c)+(a-c-d-d)
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 10d
    b dw 12d
    c dw 40d
    d dw 15d

; our code starts here
segment code use32 class=code
    start:
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        mov ax, [a]
        mov bx, [b]
        mov cx, [c]
        mov dx, [d]
        sub ax, bx ; ax=ax-bx=a-b
        sub ax, cx ; ax=ax-cx=a-b-c
        mov bx, [a]
        sub bx, cx ; bx=bx-cx=a-c
        sub bx, dx ; bx=bx-dx=a-c-d
        sub bx, dx ; bx=bx-dx=a-c-d-d
        add ax, bx ; ax=ax+bx=(a-b-c)+(a-c-d-d)
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
