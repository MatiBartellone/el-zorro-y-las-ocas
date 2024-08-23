
extern printf, gets, puts, system

; Imprime un string hasta que encuentra un 0 y agrega \n
%macro mPrint 1
    mov     rdi, %1
    sub     rsp,8
    call    puts
    add     rsp,8
%endmacro

; Convierte a string cada uno de los parámetros y los imprime con el formato indicado por pantalla.
%macro mPrintf 0
    sub     rsp,8
    call    printf
    add     rsp,8
%endmacro


%macro mInput 1
    mov     rdi, %1
    sub     rsp,8
    call    gets
    add     rsp,8
%endmacro

%macro mClear 0
    mov     rdi, clearCmd
    sub     rsp,8
    call    system
    add     rsp,8
%endmacro