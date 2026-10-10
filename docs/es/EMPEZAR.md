# Empezar

Este repositorio no trae el juego. Trae las herramientas que, a partir de tu
propia imagen del cartucho, vuelven a montar el listado comentado, lo
reensamblan y comprueban que sale la ROM **byte a byte**.

## Lo que hace falta

- La imagen de *Nemesis 2* (RC-751), 131.072 bytes, en la raíz con el nombre
  `nemesis2.rom`. Su sha256:
  `227113f94d9900cb48d2f9e88627224dd8cc3d9504614a01e94cf6b23ba508dc`.
- `make`, `python3` y el ensamblador `pasmo`.
- Para las imágenes, Python con PIL.

## Lo que se ejecuta

    make comprueba     # el sha256 de la ROM
    make               # traza, genera el listado, reensambla y pasa los tests
    make densidad      # cuántas instrucciones llevan comentario, banco a banco
    make sanity        # el presupuesto: ni un byte sin asignar

`make verify` reensambla los dieciséis bancos y los compara con la ROM: tiene
que decir `OK: la ROM entera reproducible byte a byte`.

## Dónde está cada cosa

- `src/nemesis2_pNN.asm`: el listado de cada banco (p00 a p15).
- `src/pNN.notes`: los nombres, los comentarios y los bloques de datos de
  cada banco. El listado se genera desde aquí.
- `tools/anota.py` y `tools/anotaciones.py`: los nombres de las rutinas y de
  la RAM, y los comentarios automáticos.
- `tools/cartucho.py`: lo que el trazador necesita saber del mapper.
- `tools/dibuja.py`, `tools/vram.py`, `tools/titulo.py`, `tools/objetos.py`,
  `tools/enemigos.py`, `tools/nave.py`, `tools/final.py`: las imágenes,
  dibujadas desde la ROM.

## Las imágenes

    python tools/dibuja.py mapas work/dibujos
    python tools/titulo.py png work/dibujos/titulo.png --escala 2
    python tools/objetos.py work/dibujos/objetos
    python tools/enemigos.py png work/dibujos/enemigos
    python tools/nave.py png work/dibujos/armas/nave.png
    python tools/final.py png work/dibujos/final --escala 3
