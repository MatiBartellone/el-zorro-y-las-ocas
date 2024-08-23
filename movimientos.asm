extern posZorro, ocaActual, posSiguiente, jugadorActual

global movimiento_a, movimiento_c, movimiento_d, movimiento_e, movimiento_q, movimiento_w, movimiento_x, movimiento_z

section .data
    mov_q db -11
    mov_w db -1
    mov_e db 9
    mov_a db -10
    mov_d db 10
    mov_z db -9
    mov_x db 1
    mov_c db 11
    
section .text

actual_zorro:
    mov rax, [posZorro]
    mov [posSiguiente],rax

actual_oca:
    mov rax, [ocaActual]
    mov [posSiguiente], rax

definir_actual:
    cmp     byte [jugadorActual],0
    jz      actual_zorro ;si es zorro 
    jnz     actual_oca ; si es oca

movimiento_q:
    call definir_actual
    mov rax, mov_q
    add [posSiguiente],rax
movimiento_w:
    call definir_actual
    mov rax, mov_w
    add [posSiguiente],rax
movimiento_e:
    call definir_actual
    mov rax, mov_e
    add [posSiguiente],rax
movimiento_a:
    call definir_actual
    mov rax, mov_a
    add [posSiguiente],rax
movimiento_d:
    call definir_actual
    mov rax, mov_d
    add [posSiguiente],rax
movimiento_z:
    call definir_actual
    mov rax, mov_z
    add [posSiguiente],rax
movimiento_x:
    call definir_actual
    mov rax, mov_x
    add [posSiguiente],rax
movimiento_c:
    call definir_actual
    mov rax, mov_c
    add [posSiguiente],rax