extern printf 
extern gets
extern puts
extern strLen
extern esUnaPosValida
global main

%macro mPuts 0
    sub     rsp,8
    call    puts
    add     rsp,8
%endmacro

%macro mGets 0
    sub     rsp,8
    call    gets  
    add     rsp,8
%endmacro

%macro mPrintf 0
    sub     rsp,8
    call    printf
    add     rsp,8
%endmacro

%macro mStrLen 0
    sub     rsp,8
    call    strLen
    add     rsp,8
%endmacro

%macro mEsUnaPosValida 0
    sub     rsp,8
    call    esUnaPosValida
    add     rsp,8
%endmacro

section .data
    msgBienvenida      db "Bienvenidos al juego 'El Zorro y las Ocas'", 10,10, 0
    msgJug1            db "Jugador 1 ('Zorro') ingrese la casilla (ej. D5) o 'F' para finalizar el juego: ", 0
    msg1Jug2            db "Jugador 2 ('Ocas') ingrese la ficha a mover (ej. D5) o 'F' para finalizar el juego: ", 0
    msg2Jug2            db "Jugador 2 ('Ocas') ingrese la nueva posicion (ej. D5) o 'F' para finalizar el juego: ", 0
    msgError           db "Movimiento invalido. Intente nuevamente.", 10, 0
    msgFinal           db "Juego terminado.", 10, 0
    msgZorroGana       db "Gano el zorro!!!", 10, 0
    msgOcasGanan       db "Ganaron las ocas!!!", 10, 0

    arrValidos         db "F  C1 D1 E1 C2 D2 E2 A3 B3 C3 D3 E3 F3 G3 A4 B4 C4 D4 E4 F4 G4 A5 B5 C5 D5 E5 F5 G5 C6 D6 E6 C7 D7 E7 "
    pos3Chars1 times 3  db " "
    ;endStr1                     db  0
    pos3Chars2 times 3  db " "
    ;endStr2                     db  0
    pos3CharsZorro   times 3  db " "
    ;endStr3                     db  0
    casillaZorro       db "D5",0


    oca                db "| O |",0
    zorro              db "| X |",0
    vacio              db "|   |",0
    tableroInicial  db  "             ","  A  ","  B  ","  C  ","  D  ","  E  ","  F  ","  G  ",10
                    db  "             ","#####","#####","#####","#####","#####","#####","#####",10
                    db  "           1 ","#####","####|","| O |","| O |","| O |","|####","#####",10
			        db  "           2 ","#####","####|","| O |","| O |","| O |","|####","#####",10
			        db 	"           3 ","| O |","| O |","| O |","| O |","| O |","| O |","| O |",10
			        db 	"           4 ","| O |","|   |","|   |","|   |","|   |","|   |","| O |",10
			        db 	"           5 ","| O |","|   |","|   |","| X |","|   |","|   |","| O |",10
                    db 	"           6 ","#####","####|","|   |","|   |","|   |","|####","#####",10
                    db 	"           7 ","#####","####|","|   |","|   |","|   |","|####","#####",10
                    db  "             ","#####","#####","#####","#####","#####","#####","#####",10,10,0

section .bss
    tablero resb 2000
    inZorro resb 500
    inPos1 resb 500
    inPos2 resb 500

section .text
main:
    mov rdi, msgBienvenida
    mPrintf

    mov rdi, tableroInicial
    mPrintf

juego_loop:
    

    sub		rsp,8	
    call    validarMov1 
	add		rsp,8	

    sub		rsp,8	
    call    actualizarTablero 
	add		rsp,8

    sub		rsp,8	
    call    mostrarTablero  
	add		rsp,8

    mov rdi, msg1Jug2
    mPrintf
    mov rdi, inPos1
    mGets
    ;mov rdi, inPos1
    ;mPrintf

    sub		rsp,8	
    call    validarMov2 
	add		rsp,8

    mov rdi, msg2Jug2
    mPrintf
    mov rdi, inPos2
    mGets
    ;mov rdi, inPos2
    ;mPrintf

    sub		rsp,8	
    call    validarMov2 
	add		rsp,8

    sub		rsp,8	
    call    actualizarTablero 
	add		rsp,8

    sub		rsp,8
    call    mostrarTablero  
	add		rsp,8

    jmp juego_loop

validarMov1:
    ;Ingresa el movimiento del zorro
    mov rdi, msgJug1
    mPrintf
    mov rdi, inZorro
    mGets
    ;mov rdi, inZorro
    ;mPrintf
    
    ;Obtengo en RAX la longitud del string donde se guardo la marca
    mov     rdi,inZorro
    mStrLen

    ;Copio la posicion actual en un campo inicializado con 3 espacios en blanco
    mov rsi,inZorro
    mov rdi,pos3CharsZorro
    mov rcx,rax ;La longitud q esta en RAX la copio en RCX
    rep movsb

    mov rdi,pos3CharsZorro
    mPrintf

    ;Valido si la posicion esta en el vector de posiciones
    mov     rdi,pos3CharsZorro      ;Param 1: string con la nueva posicion del zorro
    mov     rsi,arrValidos    ;Param 2: vector con las posiciones validas
    mov     rdx,34            ;Param 3: cantidad de elementos del vector
    mov     rcx,3             ;Param 4: long de cada elmento del vector
    mEsUnaPosValida

    cmp     rax,0
    je      entradaInvalida

validarMov2:

entradaInvalida:
    mov rdi,msgError
    mPrintf
    jmp juego_loop

actualizarTablero:

mostrarTablero:
    mov rdi, tablero
    mPrintf


ret
