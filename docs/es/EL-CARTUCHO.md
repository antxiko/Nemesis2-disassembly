# El cartucho

## La máquina

Un MSX de primera generación: el VDP TMS9918 en SCREEN 2, el PSG y el SCC que
lleva el propio cartucho. Los registros del VDP salen de la tabla
`p00:5D1D`: nombres en 0x3800, colores en 0x0000, dibujos en 0x2000,
atributos de sprite en 0x3B00 y sus dibujos en 0x1800.

## El mapper

Es el de Konami con SCC: dieciséis bancos de 8 KB. El banco 0 está fijo en
0x4000 y los otros tres huecos se eligen escribiendo en 0x7000, 0x9000 y
0xB000 (`p00:4108`-`p00:415D`). El juego guarda una copia de cada uno en
`0xF0F1`-`0xF0F3`, y la interrupción los devuelve con ellas
(`p00:4050`). Escribir 0x3F en 0x9000 hace aparecer los registros del SCC en
0x9800 (`p04:71D3`).

## La interrupción

INIT (`p00:4090`) instala el gancho H.KEYI y se queda en `jr $`: todo el
juego corre dentro de la interrupción (`p00:4023`). Primero suena el sonido,
con los bancos 4-5-6 (`p04:6934`). Después, si el cuadro anterior ya ha
acabado (`0xE1C5`), se lanza un cuadro de juego: la pantalla del cuadro
anterior a la VRAM (`p00:5D2A`) y el estado del juego (`p00:5601`).

## El sonido

Está en el banco 4. Hay 8 canales de 40 bytes desde `0xE000`: 3 del PSG y 5
del SCC. Son 67 sonidos, cada uno con su cabecera de canales y prioridad
(`p04:6612`); una partitura entra en un canal solo si su prioridad no es
menor que la del que suena (`p04:655D`). Las partituras tienen 31 órdenes
(`p04:6D27`) y el SCC usa sus propias formas de onda (`p04:6000`). En la
pausa, el sonido 0xF3 guarda los canales y el 0xF2 los devuelve
(`p04:65DE`, `p04:65A1`).

## La RAM

El juego usa `0xE000`-`0xEFFF`, que INIT pone a cero. Los 12 enemigos son
fichas de 64 bytes en `0xE600`, las 10 balas van en `0xE900` y los 9
disparos de la nave en `0xE470`. La pantalla se monta en la RAM, en
`0xED00`, y cada cuadro se copia entera a la VRAM (`p01:77F1`). Los sprites
se ordenan en `0xE280` y cada cuadro se empieza por uno distinto
(`p01:77B6`), para que parpadeen en vez de desaparecer.
