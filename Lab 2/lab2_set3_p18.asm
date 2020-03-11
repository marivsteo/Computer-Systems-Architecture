;Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor.
; a,b,c - byte, d - word, 200-[3*(c+b-d/a)-300]
bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a  db 10
	b  db 40
    c db 12
    d dw 3
    
segment  code use32 class=code ; segmentul de cod
start: 
	mov eax, 0
    mov dx, 0
    mov bx, [a]
    mov ax, [d]
    div bx ; ax=dx:ax/bx=d/a
    mov bx, [b] 
    sub bx, ax ; bx=bx-ax=b-d/a
    mov cx, [c]
    add cx, bx ; cx=cx+bx=c+b-d/a
    mov ax, 3
    mul cx ; dx:ax=ax*cx=3*(c+b-d/a)
    sub cx, 300 ; cx=cx-300=3*(c+b-d/a)-300
    mov ax, 200 
    sub ax, cx ; ax=ax-cx=200-[3*(c+b-d/a)-300]

    
    
    
    
	
	push   dword 0 ;se pune pe stiva codul de retur al functiei exit
	call   [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	