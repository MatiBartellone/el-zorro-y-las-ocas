# Proyecto de Juego de Mesa

## Archivos del Proyecto

- **tp (main)**: Archivo principal que ejecuta el juego.
- **inicializacion**: Archivo para inicializar el tablero y las variables del juego.
- **validar**: Archivo que contiene la función para validar jugadas.
- **realizar_jugada**: Archivo que contiene la función para realizar las jugadas.
- **guardar_partida**: Archivo para guardar el estado actual del juego.
- **printeo**: Archivo que contiene funciones para imprimir el tablero y otros elementos visuales.
- **strlen**: Archivo para guardar funciones auxiliares (considerar cambiar el nombre para mayor claridad).

## Descripción del main

El archivo `main` contiene el flujo principal del juego. A continuación se describe su estructura:

1. **Main**:
   ```c
   tablero = inicializar_tablero();
   personaje_actual = zorro;
   while (estado_juego()) {
    clear();
    imprimir_tablero();
    if (validar_jugada(personaje_actual)) {
        realizar_jugada();
        cambiar_personaje();
    }
   printear_ganador();
   opcion de guardar partida
   }




