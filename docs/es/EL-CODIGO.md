# El código

## Las cifras

El **100 %** de los 131.072 bytes está explicado: 41.242 de código y 89.830
de datos. Los siete bancos con código tienen 2.630 rutinas y etiquetas, y
8.602 de sus 19.811 instrucciones llevan comentario: el **43,4 %**, sin
ninguna rutina por debajo del 10 %. Hay 1.361 rutinas con nombre y 327
direcciones de RAM, cada una con la dirección que lo justifica.

## Cómo se ordena

El juego tiene 11 estados (`p00:5615`): la entrada, el título, la
demostración, el principio de la partida, una vida, el juego, la muerte, GAME
OVER, la vuelta tras el interior, la pausa y el final. El cuadro de juego
(`p00:416D`) recorre los bancos en orden: el scroll, las apariciones, la
nave, sus armas, los enemigos, los choques, el jefe, los sprites y la
pantalla.

## Las apariciones

Cada fase lleva sus listas ordenadas por columna de scroll: los enemigos
(`p14:9A67`), las torretas (`p14:9554`), los objetos de caracteres
(`p12:BA12`), las cápsulas especiales (`p12:BB72`) y los bloques
(`p01:7248`). Además, cada tramo de 32 columnas elige uno o dos de los 11
generadores de relleno (`p14:99C7`, `p01:6E07`), y cada fase tiene una oleada
de 6 enemigos en grupo (`p01:6E1D`): derribarla entera deja cápsula
(`p02:8988`).

## Los enemigos

Hay 65 tipos, cada uno con una ficha de 7 bytes (`p00:4F4C`): cuántos
sprites usa o si es de caracteres, sus golpes, su caja, su dibujo y su color.
Cada tipo tiene una rutina para salir (`p00:4DF3`) y otra para cada cuadro
(`p01:63CD`). Al caer, casi todos dejan el tipo 0x26, la explosión, que con
su dato se convierte en la cápsula del medidor o en la que hace caer a todos
(`p02:9660`).

## Los nombres

Los nombres de las rutinas y de la RAM están en `tools/anotaciones.py`, y
`tools/anota.py` los lleva a cada llamada y a cada acceso del listado.
