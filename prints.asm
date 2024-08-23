%include "auxiliar.asm"
;%include "data.asm"
extern posZorro, posOcas, posInvalidas, jugadaValida, ocaValida, ocaActual, posSiguiente, movimientom, inputValido, estadoJuego, tablero, clearCmd
extern mPrint, mPrintf, puts


%macro mPrintTablero 0
    sub     rsp, 8
    call    printTablero
    add     rsp, 8
%endmacro

%macro mPrintRealizarMovimiento 0
    sub     rsp, 8
    call    printRealizarMovimiento
    add     rsp, 8
%endmacro

%macro mPrintMensajeOca 0
    sub     rsp, 8
    call    printMensajeOca
    add     rsp, 8
%endmacro

%macro mPrintMovimientoInvalido 0
    sub     rsp, 8
    call    printMovimientoInvalido
    add     rsp, 8
%endmacro

%macro mPrintOcaInvalida 0
    sub     rsp, 8
    call    printOcaInvalida
    add     rsp, 8
%endmacro

section .data
    jugador1        db "Zorro",0
    jugador2        db "Ocas",0
    msgTitulo       db "'El Zorro y las Ocas'",10,0
    msgValidas      db "El zorro se mueve en cualquier direccion",10,"Las ocas solo para adelante o a los costados",10,10,0
    msgCasilla      db "Ocas ingrese la casilla a mover (ej. D5): ",0
    msgMovimiento   db "Movimiento a realizar: ",0
    msgMovInv       db "Movimiento invalido. Intente nuevamente.", 10, 0
    msgOcaInvalida  db "Oca invalida", 10, 0
    msgFinal        db "Juego terminado.", 10, 0
    msgGanador      db "Gano el %s!!!", 10, 0
    filas           db 7
    columnas        db 7
    saltoDeLinea    db 10


section .text
printTablero:
    mPrint msgTitulo
    mPrint      msgValidas
    mov         rsi, tablero     ; puntero al inicio de la matriz
    mov         rdx, filas       ; contador de filas
print_loop:
    mov         rcx, columnas    ; contador de columnas
print_row:
    mov         rdi, rsi         ; puntero al elemento actual
    mPrint      rdi              ; imprimo el elemento
    add         rsi, 1           ; avanza al siguiente elemento
    dec         rcx              ; decrementa contador de columnas
    jnz         print_row        ; repite mientras haya columnas

    mov         rdi, saltoDeLinea  
    mPrint rdi                   ; imprime un salto de línea entre filas

    dec         rdx              ; decrementa contador de filas
    jnz         print_loop       ; repite mientras haya filas
    ret

printRealizarMovimiento:
    mPrint      msgCasilla

printMensajeOca:
    mPrint      msgCasilla

printMovimientoInvalido:
    mPrint      msgMovInv

printOcaInvalida:
    mPrint      msgOcaInvalida

printGanador:
    mov       rdi, msgGanador
    mov rsi,estadoJuego
    mPrintf   ; segun estado juego debe imprimir el ganador