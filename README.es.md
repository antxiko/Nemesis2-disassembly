# Nemesis 2 - desensamblado comentado

*(Also [in English](README.md).)*

El desensamblado comentado de **Nemesis 2** (Konami, 1987, RC-751) para MSX:
un MegaROM de 128 KB con el mapper de Konami con SCC, dieciséis bancos de
8 KB.

- **100 %** del binario explicado: 41.242 bytes de código y 89.830 de datos
  con nombre, ni un byte sin asignar.
- **43,4 %** del listado comentado, 2.630 rutinas y etiquetas, ninguna por
  debajo del 10 % de comentarios.
- El listado se reensambla en la ROM original **byte a byte**.
- Las doce fases, los enemigos, los objetos, los cinco jefes, la nave, los
  rótulos del medidor, el título y el final del interior están **dibujados
  desde la ROM**, no capturados.

La web: <https://antxiko.github.io/Nemesis2-disassembly/es/>
(en inglés: <https://antxiko.github.io/Nemesis2-disassembly/>).

## Reproducirlo

La imagen del cartucho no se distribuye. Pon la tuya en la raíz como
`nemesis2.rom` (sha256 `227113f9...`) y ejecuta `make`. El detalle, en
[EMPEZAR](docs/es/EMPEZAR.md).

## Legal

El juego es de Konami y de sus titulares. La licencia de `LICENSE` cubre solo
las herramientas, los comentarios, el análisis y la documentación de aquí.
Mira [AVISO-LEGAL.md](AVISO-LEGAL.md).
