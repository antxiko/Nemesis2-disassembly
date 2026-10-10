# Hallazgos

Lo que apareció al desmontar el cartucho. Todo está leído en el código; lo
que no se ha comprobado jugando se dice.

## Tres palabras en la pausa, con Q*bert al lado

Con F1 se para el juego y se puede teclear (`p03:BD7C`), pero solo si en el
otro slot está el cartucho de *Q\*bert* (`0xF0F5` bit 0). Con RETURN se
compara lo tecleado con tres palabras (`p03:BEB0`):

- **LARS18TH** da el medidor y las armas enteras, con escudo y dos opciones
  (`p03:BDD8`).
- **NEMESIS** salta a la fase siguiente (`p03:BE87`).
- **METALION** deja la nave intocable 30 veces 32 cuadros (`p03:BE90`).

## El otro cartucho cuenta

Al arrancar, el juego mira los cuatro slots y sus subslots (`p03:BCB1`):

- Con *Maze of Galious* en el otro slot, al caer se guarda el equipo (`p02:8E7C`), y la
  casilla BACK UP del medidor lo devuelve en la vida siguiente (`p01:7DD9`).
- Con *Penguin Adventure*, la nave es un pingüino, azul para el jugador 1 y
  magenta para el 2 (`p03:A82E`).
- Con un cartucho que lleve unos 6 bytes concretos en 0x7FFA, el récord no
  se apunta (`p00:5B68`) y al acabar no sale el código de la puntuación
  (`p00:5C12`).

## Tres fases secretas

En las fases 3, 6 y 10 hay una entrada escondida en una columna fija
(`p03:BF3A`). Al tocarla, el scroll se para 64 cuadros, caen todos los
enemigos y luego corre a doble velocidad hasta la fase 9, la 10 o la 11.
Están hechas de bloques que se rompen (el carácter 0xA0, `p02:8481`) y su
lista lleva cápsulas (`p01:7248`). Al acabar se vuelve
a la fase que tocaba (`p01:7AC2`).

## Al jefe hay que entrarle

Vencerlo no basta: si la nave no entra por su boca en 300 cuadros, no hay
interior ni arma capturada (`p11:A95B`).

## El final lo marca el texto

Al vencer al jefe de la fase 7 sale DR.VENOM IS FAST APPROACHING NEMESIS,
RETURN IMMEDIATELY! (`p14:94D1`) y empieza la vuelta. El final de verdad
llega tras el núcleo de la fase 0 (`p10:BBAC`): OPERATIONS TO ERADICATE VENOM
WERE ACHIEVED BY METALION.

## Un `jr z` que mira otra cosa

En `p03:B72E` el `jr z` va detrás de un `ld`, que no toca las banderas: lo
que mira es el `cp 028h` de antes. Por eso la clase 1 tiene 10 golpes solo
si su Y es exactamente 0x28, y 7 en cualquier otro caso.

## Japón o no

El byte 0x002B de la BIOS decide entre GRADIUS y NEMESIS en el título
(`p01:6173`), y entre los textos japoneses y los ingleses en la historia y en
el final (`p10:A0A7`).
