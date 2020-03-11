; 25. Se citeste de la tastatura un sir de numere in baza 10, cu semn. Sa se determine valoarea maxima din sir si sa se afiseze in fisierul max.txt (fisierul va fi creat) valoarea maxima, in baza 16.

bits 32
global start

extern exit, scanf, printf, fopen, fprintf, fclose, fwrite
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fwrite msvcrt.dll

%include "maximum.asm"

segment data use32 class=data public
    message1 db "Number of elements = ", 0
    message2 db "Input the elements of the string one by one:\n", 0
    accessMode db "w", 0
    fileName db "max.txt", 0
    decimal db "%d", 0
    hexa db "%x", 0
    fileDescriptor dd -1
    max dd 0
    current dd 0
    len dd 0
    string times 100 dd 0

    
    
segment code use32 class=code


readNrOfElems:
    ; read the number of the elements of the string
    push dword message1 
    call [printf]
    add esp, 4*1
    
    push dword len
    push dword decimal
    call [scanf]
    add esp, 4*2
    
    ret


readElements:
    ; read the elements of the string

    mov edi, string
    
    readCurrent:
        ; read the current element
        push dword current
        push dword decimal
        call [scanf]
        add esp, 4*2
        
        mov eax, [current]
        stosd
        dec dword[len]
        jnz readCurrent
        
    ret

    
;maximum:
 
    ; mov esi, string
    ; mov dword[max], -2147483648 ; numar foarte mic
    
    ; nextElem:
        ; lodsd
        ; cmp [max], eax
        ; jge smallerElem
        ; mov [max], eax
        ; smallerElem:
        ; dec dword[len]
        ; jnz nextElem

    ; ret
    

writeMaximumValue:
    ; open file "max.txt" for writing
    push dword accessMode
    push dword fileName
    call [fopen]
    add esp, 4*2
    
    ; verify if the file was opened successfully
    cmp eax, 0
    je couldNotOpenFile
    mov [fileDescriptor], eax
    
    ; write the maximum value into the file
    push dword [max]
    push dword decimal
    push dword [fileDescriptor]
    call [fprintf]
    add esp, 4*3
    
    ; close the file
    push dword [fileDescriptor]
    call [fclose]
    add esp, 4*1
    
    couldNotOpenFile:
    
    ret
    
    
start:

    ; read the number of elements
    call readNrOfElems
    
    ; verify if the string is void
    cmp dword[len], 0
    je voidString
    
    mov ebx, [len] ; save the number of elements
    
    ; read elements
    call readElements
    mov [len], ebx
    
    
    ; find the maximum value of the elements
    pushad
    
    push dword string
    push dword len
    call maximum
    mov [max], edx
    mov [len], ebx
    
    popad
    
    mov [len], ebx
    
    ; print the maximum value
    call writeMaximumValue
    
    voidString:
    
    push dword 0
    call [exit]
