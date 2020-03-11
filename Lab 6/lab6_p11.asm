; 11. Se da un sir A de dublucuvinte. Construiti doua siruri de octeti  
; - B1: contine ca elemente partea superioara a cuvintelor superioare din A
; - B2: contine ca elemente partea inferioara a cuvintelor inferioare din A

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 12345678h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
    len equ ($-a)/4
    b1 times len db 0
    b2 times len db 0

; our code starts here
segment code use32 class=code
    start:
        
        cld          ; pentru a parcurge sirul a de la stanga la dreapta (DF = 0)
        mov ecx, len ; pentru a parcuge cate un dublucuvant din a in bucla de len ori
        mov edi, b1  ; pentru a pune rezultatul corect in b1
        mov esi, a   ; pentru a avea in esi sirul pe care facem operatiile
        
        jecxz end
        
        parcurge1:
                
                lodsd       ; in eax vom avea dublucuvantul curent din a (eax := ds:esi)
                shr eax, 24 ; pentru a avea in al partea inferioara a cuvantului inferior din dublucuvantul curent
                stosb       ; punem in b1 partea inferioara a cuvantului inferior din dublucuvantul curent (es:edi := al)
                
        loop parcurge1
        
        mov esi, a   ; pentru a avea in esi sirul pe care facem operatiile
        cld          ; pentru a parcurge sirul a de la stanga la dreapta (DF = 0)
        mov ecx, len ; pentru a parcuge cate un dublucuvant din a in bucla de len ori
        mov edi, b2  ; pentru a pune rezultatul corect in b2
        
        jecxz end
        
        parcurge2:
                
                 
                lodsd       ; in eax vom avea dublucuvantul curent din a (eax := ds:esi)
                stosb       ; punem in b2 partea superioara a cuvantului superior din 
                            ; dublucuvantul curent (es:edi := al)
                
                
        loop parcurge2
        
        end:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
