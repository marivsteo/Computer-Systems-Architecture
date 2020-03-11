bits 32

%ifndef _MAXI_ASM_
%define _MAXI_ASM_
maximum:
    ; find the maximum value of the string
    
    mov ebx, [esp+4]
    mov esi, [esp+8]
    
    ;mov esi, ecx
    mov edx, -2147483648 ; numar foarte mic
    
    nextElem:
        lodsd
        cmp edx, eax
        jge smallerElem
        mov edx, eax
        smallerElem:
        dec ebx
        jnz nextElem

    ret 
%endif