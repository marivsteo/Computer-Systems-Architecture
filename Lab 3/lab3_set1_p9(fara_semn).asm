; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor (in interpretarea cu semn si in interpretarea fara semn).
; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
; (d+d-b)+(c-a)+d
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b dw 3
    c dd 4
    d dq 5

; our code starts here
segment code use32 class=code
    start:
        
        ; (d+d-b)+(c-a)+d
        mov ebx, dword [d]
        mov eax, dword [d+4] ; eax:ebx=d-b
        mov edx, dword[d]
        mov ecx, [d+4] ; ecx:edx=d
        add ebx, edx     ; ebx=ebx+edx
        adc eax, ecx     ; eax=eax+ecx+CF
        sub ebx, [b]     ; ebx=ebx-b
        sbb eax, 0       ; eax=eax-0-CF
        mov cx, [c]
        mov dx, [c+2]   ; cx:dx=c
        sub dx, [a]      ; dx=dx-a
        push dx
        push cx
        pop ecx          ; ecx=cx:dx
        add ebx, ecx     ; ebx=ebx+ecx
        adc eax, 0       ; eax=eax+0+CF
        mov edx, dword [d]
        mov ecx, dword [d+4] ; ecx:edx=d
        add ebx, edx     ; ebx=ebx+edx
        adc eax, ecx     ; eax=eax+ecx+CF
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
