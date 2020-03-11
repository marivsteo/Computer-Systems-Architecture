bits 32 ; assembling for the 32 bits architecture

global _convert
extern _printf

segment data public data use32
    decimal db "The number in base 16 is: %X ", 0


segment code public code use32

_convert:
    
    push ebp
    mov ebp, esp
    
    pushad
    
    mov eax, [ebp + 8]
    
    push dword eax
    push dword decimal
    call _printf
    add esp, 4*2
    
    popad
    
    mov esp, ebp
    pop ebp 
  ret
