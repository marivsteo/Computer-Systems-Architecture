;Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor.
; a,b,c,d - byte, d-(a+b)+c
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10d
    b db 12d
    c db 40d
    d db 15d

; our code starts here
segment code use32 class=code
    start:
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        mov ah, [a] 
        mov bh, [b]
        add ah, bh ; ah=ah+bh=a+b=10+12
        mov ch, [c]
        mov dh, [d]
        sub dh, ah ; dh=dh-ah=d-(a+b)
        add dh, ch ; dh=dh+ch=d-(a+b)+c
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
