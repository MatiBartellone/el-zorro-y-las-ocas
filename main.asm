global main

%include "auxiliar.asm"
extern posZorro, posOcas, posInvalidas, jugadaValida, ocaValida, ocaActual, posSiguiente, movimientom, inputValido, estadoJuego, jugadorActual


%include "prints.asm"
extern mPrintTablero, mPrintRealizarMovimiento, mPrintMensajeOca, mPrintMovimientoInvalido, mPrintOcaInvalida

%include "validaciones.asm"

%include "tablero.asm"

section .data
    clearCmd db "clear", 0

section .text

main:
    call juegoLoop
    ;call juegoFin

juegoLoop:
    mClear
    mActualizarTablero
    mPrintTablero
    
    cmp     byte [jugadorActual], 0
    jz      zorroLoop ;si es zorro llamo zorro loop
    jnz     ocaLoop ; si es oca llamo oca loop

    cmp     byte [estadoJuego], 0
    Jz      juegoLoop

zorroLoop:
    call    pedirMovimiento ; pido movimiento y se guarda en posSiguiente

    call    moverZorro

    mov     byte [jugadorActual],1 ;cambio jugador a Oca
    ret

ocaLoop:
    call    pedirOca ; pido oca y se guarda en ocaActual
    call    pedirMovimiento ; pido movimiento y se guarda en posSiguiente
    call    moverOca
    mov     byte [jugadorActual],0 ;cambio jugador a Zorro
    ret  



pedirMovimiento:
    mPrintRealizarMovimiento
    mInput      [movimiento] ; pide movimiento (Q,W,E,D,C,X,Z,A)

    cmp         byte [movimiento], "y"
    je          terminarPartida

    call        validarInput ; valida input y la transforma en nueva pos
    cmp         byte [inputValido], 0    ; si es invalido:
    ;Jnz         mPrintInputValido   ;   prints
    Jnz         pedirMovimiento     ;   vuelve
    mov         byte [inputValido],1 
    
    call        validarMovimiento ; valida nueva posicion

    cmp         byte [jugadaValida], 0
    Jnz         mPrintMovimientoInvalido
    Jnz         pedirMovimiento ;si es invalido repite
    mov         byte [jugadaValida],1
    ret

pedirOca:
    mPrintMensajeOca1
    call        mInput ocaActual

    cmp         byte [movimiento], "y"
    je          terminarPartida

    call        validarOca

    cmp         byte [ocaValida], 0
    Jz          mPrintOcaInvalida
    Jz          pedirOca ;si es invalido repite
    mov         byte [ocaValida], 0
    ret

moverZorro:
    mov     rax, [posSiguiente]
    mov     [posZorro], rax
    ret

moverOca:
    mov esi, posOcas               ; Cargar la dirección base de posOcas en esi
    mov edi, 0                   ; Inicializar el índice edi a 0
    call loop_oca
    ret

loop_oca:
    mov bl, [esi + edi]            ; Cargar el elemento actual del vector en bl
    cmp [ocaActual], bl              ; Comparar al (Oca actual) con bl (elemento del vector)
    mov bl, [posSiguiente]           ; Si son iguales, saltar a la etiqueta encontrado

    inc edi                        ; Incrementar el índice edi
    loop loop_oca            ; Saltar al inicio del bucle loop_existe_oca

terminarPartida:
    mClear
;guardar partida
