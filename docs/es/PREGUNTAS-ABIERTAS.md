# Preguntas abiertas

Lo que no está cerrado, dicho como tal.

## El cotejo contra el emulador

Todas las imágenes salen de la ROM, pero ninguna se ha comparado todavía
byte a byte con la VRAM de openMSX.

## La vuelta

El código manda de la fase 7 a la 6 y luego hacia atrás hasta la 0
(`p01:7C59`). No se ha comprobado jugando.

## Los dibujos de los enemigos

Cada tipo sale con el dibujo de su ficha, o con el primero de su animación
cuando su rutina lo cambia al salir. Las animaciones no están dibujadas. Los
rayos, las columnas y las lenguas que crecen (0x23, 0x24, 0x39-0x3C, 0x41) no
tienen un dibujo fijo y no salen en las hojas.

## Datos sin lector

El texto 2PLAYERS de `p10:B92B` solo se escribe porque `p01:61E7` salta sin
cargar DE. Los golpes de batería 0xB0 y 0xC0 leen fuera de su tabla
(`p04:6AAA`).

## El SCC al salir de la pausa

Al salir de la pausa, los canales del SCC se encienden con el valor de
`0xE1C0`, que es el estado del juego (`p04:65B7`).

## Los disparos de cada arma

Se conocen sus tipos y lo que hacen (`p03:ABC2`), pero no están dibujados.
