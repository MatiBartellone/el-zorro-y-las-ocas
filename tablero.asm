
extern posZorro, posOcas, posInvalidas, tablero, ocasEnJuego

section .data
    ocas            db "O",0
    zorro           db "X",0
    pared           db "#", 0
    vacio           db " ", 0
    divisor         db 10
    cantParedes     db 16

actualizarTablero:
    call tableroVacio

    mov     esi, posOcas                ; Dirección posOcas
    mov     dl, ocas                    ; Símbolo 'O'
    mov     ecx, ocasEnJuego            ; numero de ocas
    call    cargarPosiciones
    
    mov     esi, posInvalidas           ; Dirección posParedes
    mov     dl, pared                   ; Símbolo '#'
    mov     ecx, cantParedes            ; numero de paredes
    call    cargarPosiciones

    mov     esi, posZorro               ; Dirección posParedes
    mov     dl, zorro                   ; Símbolo 'X'
    mov     ecx, 1                      ; un solo zorro
    call    cargarPosiciones
    ret

tableroVacio:
    mov     ecx, 49                     ; Cargar la longitud del tablero en ecx
    mov     esi, tablero                ; Cargar la dirección base del tablero en esi
    mov     edi, 0                      ; Inicializar el índice edi a 0
    call    asignarEspacios             ; Llamar a la función para asignar espacios
    ret

asignarEspacios:
    cmp     ecx, 0                      ; Comparar ecx con 0 para verificar si terminamos
    je      terminarFuncion             ; Si ecx es 0, salir de la función

    mov     byte [esi + edi], vacio     ; Asignar ' ' al elemento actual del tablero
    inc     edi                         ; Incrementar el índice edi
    dec     ecx                         ; Decrementar el contador ecx
    loop    asignarEspacios             ; Saltar al inicio de la función para continuar asignando
    ret

terminarFuncion:
    ret

cargarPosiciones:
    ; Entrada:
    ;   esi -> dirección del vector de posiciones
    ;   dl  -> símbolo a colocar
    ;   ecx -> número de elementos
    mov     ebx, 0                      ; Inicializar el índice a 0
    mov     eax, 7                      ; Número de columnas

cargar_loop:
    ; Obtener el primer y segundo dígito
    mov     ax, [esi + ebx]             ;"CL" en ax
    mov     dh, [divisor]
    cbw
    idiv    dh                          ; al = ax/dh (columna), ah = ax % dh (fila)                                 

    ; Calcular la posición en el tablero
    mov     edx, al                     ; primer dígito -> columna
    mov     eax, ah                     ; segundo dígito -> fila
    imul    eax, 7                      ; multiplicar fila por número total de columnas
    add     edx, eax                    ; sumar columna
    mov     [tablero + edx], dl         ; colocar símbolo en la posición calculada

    ; Incrementar el índice de posOcas
    inc     ebx
    cmp     ebx, ecx
    jl      cargar_loop                 ; compara la cantidad de iteraciones con la cantidad de elementos y si son iguales ya termino
    ret