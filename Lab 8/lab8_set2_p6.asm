; 6. Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine cifra cu cea mai mare frecventa si sa se afiseze acea cifra impreuna cu frecventa acesteia. Numele fisierului text este definit in segmentul de date.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db "0123456789"
    lens equ $-s
    file_name db "lab8.2.6.txt", 0   ; numele fisierului din care citim
    acces_mode db "a+", 0             ; modul de acces al fisierului - a+, pentru citire
    file_descriptor dd -1            ; descriptorul fisierului folosit pentru a face referire la fisier
    content times 100 db 0
    lenc db 0
    count db 0
    max_count db 0
    numar db 0
    format db "Cifra %d apare de %d ori", 0

; our code starts here
segment code use32 class=code
    start:
        
        push dword acces_mode       ; deschidem fisierul
        push dword file_name        ; in eax va fi returnat descriptorul fisierului
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax  ; punem descriptorul fisierului in variabila corespunzatoare
        cmp eax, 0                  ; verificam daca fisierul a fost deschis cu succes
        je final
        
        
        
        push dword [file_descriptor]   ; citim cate un element din fisier
        push dword 100
        push dword 1
        push dword content
        call [fread]
        add esp, 4*4
            
        mov [lenc], eax               ; lungimea sirului content se va afla in eax dupa apelul functiei fread, deci o mutam in lenc
   
        push dword [file_descriptor]  ; apelam fclose pentru a inchide fisierul
        call [fclose]
        add esp, 4
        
        cld                 ; luam cate un element din sirul de cifre s si comparam cu fiecare element din textul citit, 
        mov esi, s          ; tinand minte de cate ori apare
        mov edi, content
        mov ecx, lens       ; vom repeta primul loop de lens ori
        string_loop:
            lodsb
            mov bx, 0
            mov edi, content
            push ecx
            mov ecx, 0
            mov cl, [lenc]  ; pentru a repeta content_loop de lenc ori
            content_loop:
                scasb     ; comparam un element din s (care se afla in al) cu un element din content (care se afla in edi)
                jne skip
                inc bl    ; daca sunt egale incrementam bl
            skip:
                loop content_loop
            pop ecx
            cmp bx, max_count   ; comparam frecventa curenta cu cea maxima
            jnge aici
            mov edx, 0
            mov dl, [s+esi]   ; retinem cifra si numarul de aparitii
            mov [max_count], bl
            aici:
            mov bl, 0
            loop string_loop
        
        
        push dword [max_count]
        push edx          ; afisam rezultatul cerut
        push dword format
        call [printf]
        add esp, 4*3
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
