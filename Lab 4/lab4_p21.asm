; 21. Se dau cuvintele A si B. Se cere dublucuvantul C:
; bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
; bitii 4-10 ai lui C sunt invers fata de bitii 0-6 ai lui B
; bitii 11-18 ai lui C sunt 1
; bitii 19-31 ai lui C coincid cu bitii 19-31 ai lui B
; indexarea incepe din dreapta

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0100100100111000111001100000111b
    b dd 0011011010001100110000011101011b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        mov bx, 0 ; rezultatul va fii in registrul bx
        mov ax, [b]
        and ax, 0000000000000000000000111100000b ; izolam bitii 5-8 din b
        mov cl, 5
        ror ax, cl ; rotire cu 5 pozitii spre dreapta pentru ca bitii 5-8 din b sa fie pe pozitiile 0-3
        or bx, ax ; punem bitii in bx
        
        mov ax, [b]
        not ax ; inversam toti bitii din b
        and ax, 0000000000000000000000001111111b ; izolam bitii 0-6 din b
        mov cl, 4
        rol ax, cl ; rotire cu 4 pozitii spre stanga pentru ca bitii 0-6 din b sa fie pe pozitiile 4-10
        or bx, ax ; punem bitii in bx
        
        or bx, 0000000000001111111100000000000b ; setam bitii 11-18 din c cu valoarea 1
        
        mov ax, [b]
        and ax, 1111111111111000000000000000000b ; izolam bitii 19-31 din b
        or bx, ax ; punem bitii in bx
    
        mov [c], bx ; punem valoarea ceruta(rezultatul) in c
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
