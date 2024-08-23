global data
global posZorro
global posOcas
global posInvalidas
global ocasEnJuego
global ocasCapturadas
global jugadorActual
global jugadaValida
global inputValido
global ocaValida
global estadoJuego
global ocaActual
global posSiguiente
global tablero
global movimiento

section .data
    
    posZorro        db 34
    posOcas         db 20, 31, 40, 21, 31, 41, 02, 12, 22, 32, 42 ,52, 62, 03, 04, 63, 64
    posInvalidas    db 00, 10, 01, 11, 50, 51, 60, 61, 05, 15, 06, 16, 55, 56, 65, 66
    ocasEnJuego     db 17
    ocasCapturadas  db 0
    jugadorActual   db 0; 0 es zorro/1 es oca
    jugadaValida    db 1; 0 False/ 1 True
    inputValido     db 1; 0 False/ 1 True
    ocaValida       db 1; 0 False/ 1 True
    estadoJuego     db 0; 0 jugando, 1, gano el zorro, -1 gano ocas

section .bss
    tablero         resb 49 ; 49 caracteres
    ocaActual       resb 100
    posSiguiente    resb 100
    movimiento      resb 100