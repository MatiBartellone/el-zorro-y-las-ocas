global  esUnaPosValida

extern posZorro, posOcas, posInvalidas, jugadaValida, ocaValida, ocaActual, posSiguiente, movimiento, inputValido, estadoJuego

extern movimiento_q, movimiento_w ,movimiento_e ,movimiento_a ,movimiento_d ,movimiento_z, movimiento_x, movimiento_c

section .data

section .bss

section .text
    ;extern movimiento_q
    ;extern movimiento_w
    ;extern movimiento_e
    ;extern movimiento_a
    ;extern movimiento_d
    ;extern movimiento_z
    ;extern movimiento_x
    ;extern movimiento_c

validarInput:
    ;super switch que calcula posSiguiente
    cmp byte [movimiento],"q"
    je movimiento_q
    cmp byte [movimiento],"w"
    je movimiento_w
    cmp byte [movimiento],"e"
    je movimiento_e
    cmp byte [movimiento],"a"
    je movimiento_a
    cmp byte [movimiento],"d"
    je movimiento_d
    cmp byte [movimiento],"z"
    je movimiento_z
    cmp byte [movimiento],"x"
    je movimiento_x
    cmp byte [movimiento],"c"
    je movimiento_c


    call invalidarJugada ;si no cumple ninguna invalido

    ret

validarMovimiento:
    cmp byte [posSiguiente], 0 
    jl invalidarJugada ;si es < 0
    cmp byte [posSiguiente],66
    jg invalidarJugada ;si es > 66
    mov rax, [posSiguiente]
    mov rcx,10
    IDIV rcx
    cmp AH,7 ;;;;;;;
    je invalidarJugada ; si es igual a 7
    cmp AH,9
    je invalidarJugada ; si es igual a 9
    call validarPosicion
    ret

validarPosicion:
    mov esi, posOcas               ; Cargar la dirección base de posOcas en esi
    mov edi,0                      ; Inicializar el índice edi a 0
    call compara_loop

    mov esi, posInvalidas               ; Cargar la dirección base de posOcas en esi
    mov edi, 0
    call compara_loop 

    mov rax, [posZorro]
    cmp rax, [posSiguiente]
    je invalidarJugada

    ret


compara_loop:
    mov bl, [esi + edi]            ; Cargar el elemento actual del vector en bl
    cmp [posSiguiente], bl           ; Comparar a la siguiente posicion con bl (elemento del vector)
    je  invalidarJugada               ; Si son iguales, saltar a la etiqueta encontrado

    inc edi                        ; Incrementar el índice edi                    
    loop compara_loop               ; Saltar al inicio del bucle compara_loop
    
    


invalidarJugada:
    mov byte [jugadaValida], 0 ;invalida la jugada
    ret

invalidarOca:
    mov byte [ocaValida], 0
    ret


validarOca:
    mov esi, posOcas               ; Cargar la dirección base de posOcas en esi
    mov edi, 0                   ; Inicializar el índice edi a 0
    call loop_existe_oca
    ret

loop_existe_oca:
    mov bl, [esi + edi]            ; Cargar el elemento actual del vector en bl
    cmp [ocaActual], bl              ; Comparar al (Oca actual) con bl (elemento del vector)
    je  invalidarOca               ; Si son iguales, saltar a la etiqueta encontrado

    inc edi                        ; Incrementar el índice edi                      
    loop loop_existe_oca            ; Saltar al inicio del bucle loop_existe_oca