; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor (in interpretarea cu semn si in interpretarea fara semn).
; (a-b+c*128)/(a+b)+e-x; a,b-byte; c-word; e-doubleword; x-qword (fara semn)
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
    b db 3
    c dw 4
    e dd 5
    x dq 6

; our code starts here
segment code use32 class=code
    start:
        
        ; (a-b+c*128)/(a+b)+e-x
        mov ax, [c]
        mov bx, 128
        mul bx ; dx:ax=ax*bx=c*128
        mov bl, [a]
        mov cl, [b]
        sub bl, cl ; bl=bl-cl=a-b
        mov bh, 0 ; bx=a-b
        mov cx, 0
        add ax, bx
        adc dx, cx ; dx:ax=a-b+c*128
        mov bl, [a]
        mov bh, 0 ; bx=a
        mov cl, [b]
        mov ch, 0 ; cx=b
        add bx, cx ; bx=bx+cx=a+b
        mov cx, 0
        push bx
        push cx
        pop ecx ; ecx=a+b
        div ecx ; dx:ax=(a-b+c*128)/(a+b)
        push ax
        push dx
        pop eax ; eax=(a-b+c*128)/(a+b)
        mov ebx, [e]
        add eax, ebx
        mov edx, 0 ; edx:eax=(a-b+c*128)/(a+b)
        mov ebx, dword[x]
        mov ecx, dword[x+4] ; ecx:ebx=x
        sub eax, ebx
        sbb edx, ecx ; edx:eax=(a-b+c*128)/(a+b)-x
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
