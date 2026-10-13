# La música

Todo lo que suena aquí sale de ejecutar el motor de sonido del cartucho (el sonido del cuadro, p04:6934, y `sonido`, p00:4AE4, que apunta la pieza; la interrupción lo llama en p00:4048 con los bancos 4, 5 y 6) en un Z80 emulado, cuadro a cuadro y a 60 por segundo, igual que lo llama el juego. Lo que el motor escribe en el PSG pasa a sonido con un AY-3-8910 (`tools/musica.py`). Cada MP3 es la pieza entera hasta donde vuelve a empezar, más 8 segundos de la vuelta apagándose; las que no se repiten acaban donde acaba el motor.

## Cotejado con openMSX

Las escrituras al PSG se han comparado cuadro a cuadro con las de openMSX (C-BIOS MSX1 japonés). En todos los cuadros el PSG queda igual:

- la pieza 0x3E entera, 355 cuadros, tal como el juego la pide, con PSG y SCC (144 registros del SCC);
- la pieza 0x29, sus primeros 217 cuadros, y la 0x2E, sus primeros 218, con PSG y SCC (112 registros del SCC cada una).

El timbre no está cotejado: es el de un AY-3-8910 de manual, no una grabación del emulador. Las sondas están en `tools/omsx_psg.tcl` y `tools/coteja_psg.py`.

## El SCC

Este cartucho lleva el chip de sonido SCC de Konami, además del PSG: cinco canales de onda de 32 muestras que suenan por 0x9800-0x98FF cuando el banco 0x3F está en 0x8000. Aquí se ejecuta el motor, se recogen sus escrituras a las formas de onda (0x9800-0x987F), los periodos (0x9880-0x9889), los volúmenes (0x988A-0x988E) y las máscaras de canales (0x988F), y se mezclan con el PSG. El SCC se ha cotejado con openMSX igual que el PSG, registro a registro; el timbre es el de un SCC de manual, no una grabación del emulador. El quinto canal comparte la forma de onda del cuarto.

## Cómo se pide una pieza

`sonido` (p00:4AE4) mete los bancos 4, 5 y 6 y llama a la rutina de p04:6480 con el número en A; por debajo del 0x28 son efectos y del 0x28 en adelante hay música. Antes se vuelca el estado de arranque con p04:71AE. La RAM del sonido está en 0xE000-0xE1D5. Las que suenan igual que otra se publican una vez, y las que duran más de 75 segundos sin volver a empezar se cortan a los 75.

## Las músicas

**La pieza del 0x5781** (0x3E)

Lo pide `L_5781`; dura 5,9 s.

<audio controls preload="none" src="../audio/musica_3E.mp3?v=e8bc159b"></audio>

**Empieza la historia** (0x3F)

Lo pide `empieza_historia`; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_3F.mp3?v=e5f57450"></audio>

**Empieza el final** (0x40)

Lo pide `final_empieza`; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_40.mp3?v=57557104"></audio>

**El final de verdad** (0x41)

Lo pide `final_de_verdad`; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_41.mp3?v=c95db9ed"></audio>

**Estalla el jefe** (0x3B)

Lo pide `jefe_estalla` y `L_915D`; dura 3,2 s.

<audio controls preload="none" src="../audio/musica_3B.mp3?v=7c127c1c"></audio>

**El aviso parpadea** (0x28)

Lo pide `aviso_parpadea`; dura 11,3 s.

<audio controls preload="none" src="../audio/musica_28.mp3?v=69f3d1f2"></audio>

**La pieza del 0x925C** (0x3A)

Lo pide `L_925C`; dura 14,7 s y vuelve a empezar en el segundo 3,5.

<audio controls preload="none" src="../audio/musica_3A.mp3?v=b24e372e"></audio>

**La pieza del 0x8ECE** (0x3D)

Lo pide `L_8ECE`; dura 1,9 s.

<audio controls preload="none" src="../audio/musica_3D.mp3?v=6e78baf5"></audio>

**La pieza del 0x583A** (0x42)

Lo pide `L_583A`; dura 5,8 s.

<audio controls preload="none" src="../audio/musica_42.mp3?v=2cc4f018"></audio>

**Pista 0x29 de la tabla** (0x29)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 48,0 s y vuelve a empezar en el segundo 16,0.

<audio controls preload="none" src="../audio/musica_29.mp3?v=1c37acc7"></audio>

**Pista 0x2B de la tabla** (0x2B)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 66,2 s y vuelve a empezar en el segundo 32,0.

<audio controls preload="none" src="../audio/musica_2B.mp3?v=85d05302"></audio>

**Pista 0x2C de la tabla** (0x2C)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 64,0 s y vuelve a empezar en el segundo 12,8.

<audio controls preload="none" src="../audio/musica_2C.mp3?v=a68ab776"></audio>

**Pista 0x2D de la tabla** (0x2D)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 59,2 s y vuelve a empezar en el segundo 28,4.

<audio controls preload="none" src="../audio/musica_2D.mp3?v=f91b18f4"></audio>

**Pista 0x2E de la tabla** (0x2E)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 19,2 s y vuelve a empezar en el segundo 0,1.

<audio controls preload="none" src="../audio/musica_2E.mp3?v=1a6ca048"></audio>

**Pista 0x30 de la tabla** (0x30)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_30.mp3?v=bafe8d8b"></audio>

**Pista 0x31 de la tabla** (0x31)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 57,0 s y vuelve a empezar en el segundo 27,8.

<audio controls preload="none" src="../audio/musica_31.mp3?v=2a4db95e"></audio>

**Pista 0x32 de la tabla** (0x32)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 64,0 s y vuelve a empezar en el segundo 29,9.

<audio controls preload="none" src="../audio/musica_32.mp3?v=3f027d73"></audio>

**Pista 0x33 de la tabla** (0x33)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 42,7 s y vuelve a empezar en el segundo 8,6.

<audio controls preload="none" src="../audio/musica_33.mp3?v=a688c18d"></audio>

**Pista 0x34 de la tabla** (0x34)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 25,6 s y vuelve a empezar en el segundo 12,8.

<audio controls preload="none" src="../audio/musica_34.mp3?v=f39a323a"></audio>

**Pista 0x35 de la tabla** (0x35)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 13,2 s y vuelve a empezar en el segundo 0,4.

<audio controls preload="none" src="../audio/musica_35.mp3?v=808aaee8"></audio>

**Pista 0x36 de la tabla** (0x36)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 50,8 s y vuelve a empezar en el segundo 25,2.

<audio controls preload="none" src="../audio/musica_36.mp3?v=20269543"></audio>

**Pista 0x5B de la tabla** (0x5B)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 55,5 s y vuelve a empezar en el segundo 0,1.

<audio controls preload="none" src="../audio/musica_5B.mp3?v=06b0273d"></audio>
