; 6. Se dau doua numere naturale a si b (a: dword, b: word, definite in segmentul de date). Sa se calculeze a/b si sa se afiseze catul impartirii in urmatorul format: "<a>/<b> = <cat>"
; Exemplu: pentru a = 200 si b = 5 se va afisa: "200/5 = 40"
; Valorile vor fi afisate in format decimal (baza 10) cu semn.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf       ; tell nasm that exit and printf exist
import exit msvcrt.dll
import printf msvcrt.dll  ; tell nasm that printf is in msvcrt.dll library
                          
                      

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 2500
    b dw 50
    format db "%d/%d=%d", 0 ; definim formatul

; our code starts here
segment code use32 class=code
    start:
        
        mov ax, word [a]
        mov dx, word [a+2]    ; dx:ax = a
        
        idiv word [b]         ; ax = dx:ax / b, dx = dx:ax % b
        
        cwde                  ; punem catul in eax
        
        mov ebx, eax          ; retinem catul impartirii in ebx deoarece eax poate fi folosit in interiorul functiei
        
        
        mov ax, [b]
        cwde                  ; mutam valoarea lui b pe 32 de biti pentru a o putea pune pe stiva
        mov esi, eax          ; retinem valoarea lui b in esi
        
        
        push ebx              ; punem parametrii pe stiva de la dreapta la stanga
        push esi
        push dword [a]
        push dword format
        
        call [printf]         ; apelam functia printf
        add esp, 4*4          ; eiberam parametrii de pe stiva
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
