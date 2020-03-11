; 10. Se dau doua siruri de caractere S1 si S2. Sa se
; construiasca sirul D prin concatenarea elementelor
; sirului S2 in ordine inversa cu elementele de pe
; pozitiile pare din sirul S1. 
; Exemplu:
; S1: '+', '2', '2', 'b', '8', '6', 'X', '8'
; S2: 'a', '4', '5'
; D: '5', '4', 'a', '2','b', '6', '8'


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
    l1 equ $ - s1
    s2 db 'a', '4', '5'
    l2 equ $ - s2
    d times (l1/2+l2) db 0

; our code starts here
segment code use32 class=code
    start:
        
        mov ecx, l2 ; punem in ecx lungimea sirului s2 pentru a putea executa prima bucla de ecx ori
        mov esi, l2 ; vom folosi esi pentru a pune elementele din s2 in ordine inversa in d
        mov edi, 0  ; il vom folosi pe ebx pentru a lua cate un element din s2
        
        
        jecxz end            ; incepem concatenarea sirului s2 dupa regula din enunt si verificam intai daca ecx nu a fost setat
        loop1:
            mov al, [s2+edi] ; luam cate un element din s2
            mov [d+esi], al  ; punem elementul luat mai sus pe pozitia corespunzatoare in d
            inc edi
            dec esi          ; s2 este parcurs in ordine inversa
        loop loop1
        
        
        mov ecx, l1     ; punem in ecx lungimea sirului s1
        mov esi, l2 + 1 ; pentru a incepe sa punem elemente din s1 in d de la pozitia la care am ramas dupa ce am pus
                        ; elementele din s2
        mov edi, 1      ; pentru a parcurge elementele din s1 
        
        
        jecxz end            ; acelasi efect ca si prima utilizare, inainte de primul loop
        loop2:               ; parcurgem sirul s1 din 2 in 2 pozitii
            mov al, [s1+edi] ; luam cate un element din s1
            mov [d+esi], al  ; punem in d elementul corect din s1 (doar cele de pe pozitiile pare)
            add edi, 2       ; pentru a lua doar pozitiile pare din s1
            inc esi
            
        loop loop2
            
        
        end: ;termina programul
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
