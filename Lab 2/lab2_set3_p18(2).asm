;Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor.
; a,b,c,d-byte, e,f,g,h-word, f+(c-2)*(3+a)/(d-4)
bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a db 10
	b db 40
    c db 12
    d db 3
    e dw 4
    f dw 5
    g dw 6
    h dw 2
    
    
segment  code use32 class=code ; segmentul de cod
start: 
	
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    mov al, [c]
    sub al, 2 ;al=al-2=c-2
    mov bl, [a]
    add bl, 3 ;bl=bl+3=a+3
    mul bl ;ax=al*bl=(c-2)*(3+a)
    mov cx, [d]
    sub cx, 4 ;cx=cx-4=d-4
    div cx ;ax=dx:ax/cx=(c-2)*(3+a)/(d-4)
    mov bx, [f]
    add ax, bx ;ax=ax+bx=f+(c-2)*(3+a)/(d-4)
    
    
    
    
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	