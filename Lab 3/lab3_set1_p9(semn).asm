; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor (in interpretarea cu semn si in interpretarea fara semn).
; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
; a-d+b+b+c
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
        
        ; a-d+b+b+c
        
        mov al, [a] ; al=a
        cbw         ; ax=a
        cwde        ; eax=a
        cdq         ; edx:eax=a
        mov ebx, dword[d] 
        mov ecx, dword[d+4] ; ecx:ebx=d
        sub eax, ebx        ; eax=eax-ebx
        sbb edx, ecx        ; edx=edx-ecx-CF // a-d
        mov ecx, edx
        mov ebx, eax
        mov ax, [b] ; ax=b
        cwde ; eax=b
        cdq ; edx:eax=b
        add ebx, eax ; ebx=ebx+eax
        adc ecx, edx ; ecx=ecx+edx+CF // a-d+b
        add ebx, eax 
        adc ecx, edx ; a-d+b+b
        mov eax, [c] 
        cdq ; edx:eax=c
        add ebx,eax
        adc ecx, edx ; a-d+b+b+c
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
